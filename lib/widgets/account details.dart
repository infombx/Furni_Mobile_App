import 'package:flutter/material.dart';
import 'package:furni_mobile_app/screens/splash_screen.dart';
import 'package:furni_mobile_app/services/auth_service.dart';
import 'package:furni_mobile_app/widgets/user_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/models/user_model.dart';
import 'package:furni_mobile_app/services/update_profile.dart';

String lowercaseExceptFirst(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

class AccountDetails extends StatefulWidget {
  const AccountDetails({
    super.key,
    required this.onProfileUpdated,
    required this.currentUser,
    required this.isLoading,
  });

  final VoidCallback onProfileUpdated;
  final AppUser? currentUser;
  final bool isLoading;

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _displayName.dispose();
    _email.dispose();
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  @override
  void didUpdateWidget(covariant AccountDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentUser != oldWidget.currentUser) {
      _populateFields();
    }
  }

  void _populateFields() {
    if (widget.currentUser != null) {
      _firstName.text = widget.currentUser!.firstName;
      _lastName.text = widget.currentUser!.lastName;
      _displayName.text = widget.currentUser!.displayName;
      _email.text = widget.currentUser!.email;
    }
  }

  void _updateProfile() {
    if (_passwordFormKey.currentState!.validate()) {
      UserProfile.displayName = _displayName.text;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );
    }
  }

  void _openEditProfileSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          _populateFields();
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('FIRST NAME *', _firstName),
                  const SizedBox(height: 25),
                  _buildTextField('LAST NAME *', _lastName),
                  const SizedBox(height: 25),
                  _buildTextField('DISPLAY NAME *', _displayName),
                  const SizedBox(height: 10),
                  const Text(
                    'This will be how your name will be displayed in the account section and in reviews',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 118, 113, 113),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            // Show loading indicator
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );

                            // Get userId and JWT token from your AppUser instance
                            final userId = widget.currentUser!.id
                                .toString(); // assuming id exists
                            final jwtToken = widget
                                .currentUser!
                                .jwtToken!; // you must store JWT in AppUser

                            // Call Strapi API
                            final success = await updateProfileOnStrapi(
                              userId: userId,
                              firstName: _firstName.text,
                              lastName: _lastName.text,
                              displayName: _displayName.text,
                              jwtToken: jwtToken,
                            );

                            Navigator.pop(context); // close loading

                            if (success) {
                              // Update the AppUser instance locally
                              setState(() {
                                widget.currentUser!
                                  ..firstName = _firstName.text
                                  ..lastName = _lastName.text
                                  ..displayName = _displayName.text;
                              });

                              widget.onProfileUpdated(); // notify parent
                              Navigator.pop(context); // close bottom sheet

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Profile updated successfully!',
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to update profile.'),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xff6C7275),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,

          decoration: InputDecoration(
            labelText: lowercaseExceptFirst(label),
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading || widget.currentUser == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Form(
        key: _passwordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 25),
            _buildReadOnlyField('EMAIL *', _email),
            const SizedBox(height: 25),
            _buildReadOnlyField('FIRST NAME *', _firstName),
            const SizedBox(height: 25),
            _buildReadOnlyField('LAST NAME *', _lastName),
            const SizedBox(height: 25),
            _buildReadOnlyField('DISPLAY NAME *', _displayName),
            const SizedBox(height: 10),
            const Text(
              'This will be how your name will be displayed in the account section and in reviews',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 118, 113, 113),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 183,
                height: 52,
                child: ElevatedButton(
                  onPressed: _openEditProfileSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: SizedBox(
                width: 183,
                height: 52,
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthService().logout();

                    if (!context.mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const SplashScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xff6C7275),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          ),
        ),
      ],
    );
  }
}
