import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/widgets/account%20details.dart';
import 'package:furni_mobile_app/widgets/address_details.dart';
import 'package:furni_mobile_app/widgets/footer/profile_picture.dart';
import 'package:furni_mobile_app/widgets/user_profile.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String _selectedValue = 'Account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
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
                      // Center(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 15),
                      //     child: ProfilePicture(
                      //       imagePath: UserProfile.profileImagePath,
                      //       onImageSelected: (path) {
                      //         setState(() {
                      //           UserProfile.profileImagePath = path;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 15),
                      Text(
                        UserProfile.displayName,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        onProfileUpdated: () {
                          setState(() {});
                        },
                      )
                    : const AddressDetails(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
