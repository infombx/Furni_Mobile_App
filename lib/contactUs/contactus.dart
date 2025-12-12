import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/contactUs/about.dart';
import 'package:furni_mobile_app/contactUs/widget/contactForm.dart';
import 'package:furni_mobile_app/contactUs/widget/services.dart';
import 'package:furni_mobile_app/contactUs/widget/shopnow.dart';
import 'package:google_fonts/google_fonts.dart';

class Contactus extends StatelessWidget{
  const Contactus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Header()),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              About(),
              SizedBox(height: 20),
              Shopnow(),
               SizedBox(height: 20),
              Text('Contact Us',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                fontFamily: GoogleFonts.poppins().fontFamily  
              ),
              ),
             
             SizedBox(height: 40),
             Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)
              ),
              height: 160,
              child: Center(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/store.svg'),
                    SizedBox(height: 10),
                    Text('ADDRESS',
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color.fromARGB(255, 108, 114, 117)
                    ),),
                    SizedBox(height: 5),
                    Text(textAlign: TextAlign.center,'234 Hai Trieu, Ho Chi Minh City, Viet Nam', 
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),)

                  ],
                ),
              ),
             ),
             SizedBox(height: 16),
              Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)
              ),
               height: 160,
              child: Center(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/phone.svg'),
                    SizedBox(height: 10),
                    Text('CONTACT US',
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color.fromARGB(255, 108, 114, 117)
                    ),),
                    SizedBox(height: 5),
                    Text(textAlign: TextAlign.center,'+84 234 567 890', 
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),)

                  ],
                ),
              ),
             ),
             SizedBox(height: 16),
              Container(
              height: 160,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/mail.svg'),
                    SizedBox(height: 10),
                    Text('EMAIL',
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color.fromARGB(255, 108, 114, 117)
                    ),),
                    SizedBox(height: 5),
                    Text(textAlign: TextAlign.center,'hello@furni.com', 
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),),
                  ],
                ),
              ),
             ),
              SizedBox(height: 32),
              Contactform(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: (){}, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  )
                ),
                child: Text('Send Message', style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
                ),
              ),
              SizedBox(height: 50),
              Services()
            ],
          ),
        ),
        
      ),
    );
  }
}