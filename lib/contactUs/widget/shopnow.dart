import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Shopnow extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(13)
    ),
    child: Column(
      children: [
        Image.asset('assets/images/img1.png'),
        SizedBox(height: 20),
        TextButton(onPressed: (){}, child: Text('Shop Now',
        style:TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.inter().fontFamily,
          fontSize: 16,
          letterSpacing: -0.4
        ) ))
      ],
    ),
   );
  }
}