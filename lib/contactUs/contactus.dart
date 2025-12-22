import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/contactUs/about.dart';
import 'package:furni_mobile_app/contactUs/widget/contactForm.dart';
import 'package:furni_mobile_app/contactUs/widget/services.dart';
import 'package:furni_mobile_app/contactUs/widget/shopnow.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
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
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title:Header(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(32,0,32,0),
        child: Column(
          children: [
             Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                Navigator.pop(context, {
                });
              },
              
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 11,
                          color: Colors.black54,
                        ),
                        label: const Text('back', style: TextStyle(color: Colors.black)),
                      ),
              
                    ],
                  ),
            About(),
            const SizedBox(height: 20),
            Shopnow(),
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
      
            Container(
                height: 160,
                width: w*0.9,
              padding:
                  const EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/store.svg'),
                  const SizedBox(height: 16),
                  Text(
                    'ADDRESS',
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color.fromARGB(255, 108, 114, 117),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '234 Hai Trieu, Ho Chi Minh City, Viet Nam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
      
            const SizedBox(height: 16),
      
            Container(
              height: 160,
              width: w* 0.9,

              padding:
                  const EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/phone.svg'),
                  const SizedBox(height: 16),
                  Text(
                    'CONTACT US',
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color.fromARGB(255, 108, 114, 117),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '+84 234 567 890',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
      
            const SizedBox(height: 16),
      
            Container(
              height: 160,
              width: w* 0.9,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/mail.svg'),
                  const SizedBox(height: 10),
                  Text(
                    'EMAIL',
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color.fromARGB(255, 108, 114, 117),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'hello@furni.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
      
            const SizedBox(height: 32),
            Location(),
            const SizedBox(height: 32),
      
            Contactform(),
            const SizedBox(height: 10),
      
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
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
            Services(),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(height: 90, child: GlassFloatingNavBar(),),
    );
  }
}
