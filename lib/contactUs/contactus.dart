import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furni_mobile_app/contactUs/about.dart';
import 'package:furni_mobile_app/contactUs/widget/contactForm.dart';
import 'package:furni_mobile_app/contactUs/widget/services.dart';
import 'package:furni_mobile_app/contactUs/widget/shopnow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/contactUs/widget/location.dart';

class Contactus extends StatelessWidget {
  const Contactus({super.key});

  Widget _infoCard(String asset, String title, String content) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SvgPicture.asset(asset),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: const Color.fromARGB(255, 108, 114, 117),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const About(),
          const SizedBox(height: 20),
          const Shopnow(),
          const SizedBox(height: 20),
          Text(
            'Contact Us',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          const SizedBox(height: 40),

          // Address Card
          _infoCard(
            'assets/images/store.svg',
            'ADDRESS',
            '234 Hai Trieu, Ho Chi Minh City, Viet Nam',
          ),
          const SizedBox(height: 16),

          // Phone Card
          _infoCard('assets/images/phone.svg', 'CONTACT US', '+84 234 567 890'),
          const SizedBox(height: 16),

          // Email Card
          _infoCard('assets/images/mail.svg', 'EMAIL', 'hello@furni.com'),
          const SizedBox(height: 32),

          // Location Widget
          const Location(),
          const SizedBox(height: 32),

          // Contact Form Widget
          const Contactform(),
          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Send Message',
              style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 50),

          // Services Widget
          const Services(),
        ],
      ),
    );
  }
}
