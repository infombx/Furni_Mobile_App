import 'package:flutter/material.dart';
import 'package:furni_mobile_app/models/user_model.dart';
import 'package:furni_mobile_app/services/update_profilepicture.dart';
import 'package:furni_mobile_app/widgets/account%20details.dart';
import 'package:furni_mobile_app/widgets/address_details.dart';
import 'package:furni_mobile_app/widgets/footer/profile_picture.dart';
import 'package:furni_mobile_app/widgets/user_profile.dart';
import 'package:furni_mobile_app/services/auth_service.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String _selectedValue = 'Account';
  AppUser? currentUser;
  bool isLoading = true;

  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await authService.fetchMe();
    setState(() {
      currentUser = user;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: Text('back', style: TextStyle(color: Colors.black)),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 11,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Center(
                child: const Text(
                  'My Account',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        width: double.infinity,
                        height: 370,
                        decoration: BoxDecoration(
                          color: Color(0xfff3f5f7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ProfilePicture(
                            imagePath: UserProfile.profileImagePath,
                            imageUrl: currentUser?.profilePictureUrl,
                            onImageSelected: (path) async {
                              setState(() {
                                UserProfile.profileImagePath = path;
                              });

                              final success = await UserProfileService()
                                  .updateProfilePicture(path);

                              if (success) {
                                await _loadUser(); // 🔁 refresh from backend
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      //display user details
                      if (isLoading)
                        const CircularProgressIndicator()
                      else if (currentUser != null)
                        Column(
                          children: [
                            Text(
                              currentUser!.displayName,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      else
                        const Text('Failed to load user'),

                      const SizedBox(height: 40),
                      Container(
                        height: 48,
                        width: 330,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedValue,
                            items: <String>['Account', 'Address'].map((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),

                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _selectedValue == 'Account'
                    ? AccountDetails(
                        currentUser: currentUser,
                        isLoading: isLoading,
                        onProfileUpdated: () {
                          setState(() {});
                        },
                      )
                    : AddressDetails(
                        currentUser: currentUser,
                        isLoading: isLoading,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
