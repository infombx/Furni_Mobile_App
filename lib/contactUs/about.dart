import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Text(
            'We believe in sustainable decor. We’re passionate about life at home.',
            style: TextStyle(
              fontSize: 28,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.6,
              )
              
          ),
          SizedBox(height: 20,),
          Text(
            'Our features timeless furniture, with natural fabrics, curved lines, plenty of mirrors and classic design, which can be incorporated into any decor project. The pieces enchant for their sobriety, to last for generations, faithful to the shapes of each period, with a touch of the present.',
            style: TextStyle(
              fontSize: 16,
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
              )
              
          )
      
        ],
      
    );
  }
}