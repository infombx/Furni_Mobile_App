import 'package:flutter/material.dart';
import 'package:teakworld/services/message_service.dart';
import 'package:google_fonts/google_fonts.dart';

class Contactform extends StatefulWidget {
  Contactform({super.key});

  @override
  State<Contactform> createState() => _ContactformState();
}

class _ContactformState extends State<Contactform> {
  final _contactMessageKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  bool isSubmitting = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (!_contactMessageKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    final success = await ContactMessageService.sendMessage(
      name: nameController.text,
      email: emailController.text,
      message: messageController.text,
    );

    setState(() => isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully')),
      );

      nameController.clear();
      emailController.clear();
      messageController.clear();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to send message')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _contactMessageKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FULL NAME',
              style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 108, 114, 117),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Your Name',
                hintStyle: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 16,
                  color: const Color.fromARGB(255, 108, 114, 117),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Text(
              'EMAIL ADDRESS',
              style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 108, 114, 117),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Your Email',
                hintStyle: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 16,
                  color: const Color.fromARGB(255, 108, 114, 117),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            Text(
              'MESSAGE',
              style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 108, 114, 117),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Your message',
                hintStyle: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 16,
                  color: const Color.fromARGB(255, 108, 114, 117),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.black),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Message is required';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: isSubmitting ? null : submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Send Message',
                        style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
