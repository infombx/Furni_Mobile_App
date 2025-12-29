import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactDetailsForm extends StatefulWidget {
  const ContactDetailsForm({super.key, this.onSaved});
  final void Function(Map<String, String> values)? onSaved;
  @override
  State<ContactDetailsForm> createState() {
    return _ContactDetatilsFormState();
  }
}

class _ContactDetatilsFormState extends State<ContactDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  String firstName = '';
  String lastName = '';
  String phone = '';
  String email = '';

  final RegExp emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$");

  String? _nonEmptyValidator(String? v, String fieldName) {
    if (v == null || v.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _phoneValidator(String? v) {
    final basic = _nonEmptyValidator(v, 'Phone number');
    if (basic != null) return basic;

    final digitsOnly = v!.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 7 || digitsOnly.length > 15) {
      return 'Enter a valid phone number (7-15 digits)';
    }
    return null;
  }

  String? _emailValidator(String? v) {
    final basic = _nonEmptyValidator(v, 'Email');
    if (basic != null) return basic;

    if (!emailRegExp.hasMatch(v!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void _handleSubmit() {
    // validate returns true if the form is valid, false otherwise
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    // save to local variables (or do onSaved)
    firstName = firstNameCtrl.text.trim();
    lastName = lastNameCtrl.text.trim();
    phone = phoneCtrl.text.trim();
    email = emailCtrl.text.trim();

    final values = {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
    };

    // optional: notify parent
    if (widget.onSaved != null) widget.onSaved!(values);

    // show success dialog (or navigate)
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Saved'),
        content: const Text('Contact details saved successfully.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(context) {
    return Container(
      height: 400,

      width: 450,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'Contact Information',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FIRST NAME',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: 160,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: firstNameCtrl,
                          validator: (v) => _nonEmptyValidator(v, 'First name'),
                          decoration: InputDecoration(
                            hintText: 'First name',
                            hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LAST NAME',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 50,
                        width: 160,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: lastNameCtrl,
                          validator: (v) => _nonEmptyValidator(v, 'Last name'),
                          decoration: InputDecoration(
                            hintText: 'Last name',
                            hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'PHONE NUMBER',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: 416,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: phoneCtrl,
                      validator: _phoneValidator,
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'EMAIL ADDRESS',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: 416,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: emailCtrl,
                      validator: _emailValidator,
                      decoration: InputDecoration(
                        hintText: 'Your Email',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
