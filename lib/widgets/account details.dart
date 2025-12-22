import 'package:flutter/material.dart';
import 'package:furni_mobile_app/widgets/user_profile.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key, required this.onProfileUpdated});
  final VoidCallback onProfileUpdated;

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
    _firstName.text = UserProfile.firstName;
    _lastName.text = UserProfile.lastName;
    _displayName.text = UserProfile.displayName;
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
                          _firstName.text = UserProfile.firstName;
                          _lastName.text = UserProfile.lastName;
                          _displayName.text = UserProfile.displayName;
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),

                        Text(
                          'FIRST NAME *',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                            letterSpacing: 0,
                            color: Color(0xff6C7275),
                          ),
                        ),
                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _firstName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim() == '') {
                              return 'First name is required';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 25),
                        Text(
                          'LAST NAME *',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                            letterSpacing: 0,
                            color: Color(0xff6C7275),
                          ),
                        ),
                        const SizedBox(height: 8),

                        TextFormField(
                          controller: _lastName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim() == '') {
                              return 'Last name is required';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 25),
                        Text(
                          'DISPLAY NAME *',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                            letterSpacing: 0,
                            color: Color(0xff6C7275),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _displayName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim() == '') {
                              return 'Display name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'This will be how your name will be displayed in the account section and in reviews',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(255, 118, 113, 113),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 400,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                UserProfile.displayName = _displayName.text;
                                widget.onProfileUpdated();

                                Navigator.pop(context); // close bottom sheet
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Profile updated successfully!',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Text(
              'EMAIL *',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xff6C7275),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              controller: _email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'FIRST NAME *',
              style: GoogleFonts.inter(
                //   fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xff6C7275),
              ),
            ),
            const SizedBox(height: 8),

            TextFormField(
              controller: _firstName,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
            ),

            const SizedBox(height: 25),
            Text(
              'LAST NAME *',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xff6C7275),
              ),
            ),
            const SizedBox(height: 8),

            TextFormField(
              readOnly: true,
              controller: _lastName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
            ),

            const SizedBox(height: 25),
            Text(
              'DISPLAY NAME *',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xff6C7275),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              controller: _displayName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
            ),

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
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 253, 252, 252),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            const Text(
              'Password',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 25),
            Text(
              'OLD PASSWORD',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xff6C7275),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _oldPassword,
              decoration: InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'Old password is required';
                }
                return null;
              },
            ),

            const SizedBox(height: 25),
            Text(
              'NEW PASSWORD',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xff6C7275),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _newPassword,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'New password is required';
                }
                return null;
              },
            ),

            const SizedBox(height: 25),
            Text(
              'REPEAT NEW PASSWORD',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: 0,
                color: Color(0xff6C7275),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _confirmPassword,
              decoration: InputDecoration(
                labelText: 'Repeat new password',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'Repeat new password is required';
                }
                return null;
              },
            ),

            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                width: 183,
                height: 52,
                child: ElevatedButton(
                  onPressed: _updateProfile,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save changes',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 253, 252, 252),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
