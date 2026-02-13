import 'dart:io';
import 'package:flutter/material.dart';
import 'package:teakworld/screens/home_screen.dart';
import 'package:teakworld/widgets/footer/profile_picture.dart';
import 'package:teakworld/services/profile_service.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedImagePath;

  final ProfileService profileService = ProfileService();

  bool isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    displayNameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      print('IMAGE PATH: $selectedImagePath');
      if (selectedImagePath != null) {
        print('IMAGE EXISTS: ${File(selectedImagePath!).existsSync()}');
      }

      final success = await profileService.createUserProfile(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        displayName: displayNameController.text.trim(),
        imagePath: selectedImagePath, // ✅ USE PICKER PATH DIRECTLY
      );

      if (!mounted) return;

      setState(() => isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully')),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            settings: const RouteSettings(name: '/home'),
            builder: (_) => const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to save profile')));
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(1, 100, 109, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Complete Your',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Profile',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Center(
              child: ProfilePicture(
                imagePath: selectedImagePath,
                onImageSelected: (path) {
                  setState(() {
                    selectedImagePath = path;
                  });
                },
              ),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Text('FIRST NAME'),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'First name is required'
                            : null,
                      ),

                      const SizedBox(height: 15),

                      const Text('LAST NAME'),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Last name is required'
                            : null,
                      ),

                      const SizedBox(height: 15),

                      const Text('DISPLAY NAME'),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: displayNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Display name is required'
                            : null,
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        'This name will be visible in reviews and account section',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 44,
              width: 311,
              child: ElevatedButton(
                onPressed: isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF184E60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Save',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
