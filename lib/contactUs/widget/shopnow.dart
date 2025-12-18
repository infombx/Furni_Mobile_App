import 'package:flutter/material.dart';
import 'package:furni_mobile_app/home_page/shopNow_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class Shopnow extends StatelessWidget{
  const Shopnow({super.key});

  @override
  Widget build(BuildContext context) {
   return 
       Column(
         children: [
          Image.asset('assets/images/img1.png',width: 311,),
           Container(
            width: 310,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text('About Us',
                style:TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 20,
                  color: Colors.black,
                ) ),
                SizedBox(height: 10),
                Text('We believe your home should feel easy to style, easy to love, and easy to live in. So we create pieces that fit beautifully into your everyday moments, without the fuss.',
                style:TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 14,
                  color: Colors.black,
                ) ),
                SizedBox(height: 30),
           
                ShopNowLink()
              ],
            ),
              ),
         ],
       );
  }
}