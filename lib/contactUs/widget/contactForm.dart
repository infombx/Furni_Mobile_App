import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contactform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text('FULL NAME',
      style: TextStyle(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 108, 114, 117)
      ),),
      SizedBox(height: 8,),
      Container(
         padding: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1
          )
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Your Name',
            hintStyle: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 108, 114, 117)
            ),
            border: InputBorder.none
          ),
        ),
      ),
      SizedBox(height: 16,),
      Text('EMAIL ADDRESS',
      style: TextStyle(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 108, 114, 117)
      ),),
      SizedBox(height: 8,),
      Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1
          )
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Your Email',
            hintStyle: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 108, 114, 117)
            ),
            border: InputBorder.none
          ),
        ),
      ),
      SizedBox(height: 12,),
      Text('MESSAGE',
      style: TextStyle(
        fontFamily: GoogleFonts.inter().fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 108, 114, 117)
      ),),
      SizedBox(height: 8,),
      Container(

        padding: EdgeInsets.all(16),
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1
          )
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Your message',
            hintStyle: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 108, 114, 117)
            ),
            border: InputBorder.none
          ),
        ),
      ),
      SizedBox(height: 12,),
   ],
    ),
    );
  }
}