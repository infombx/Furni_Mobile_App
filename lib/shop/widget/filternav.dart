import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Filternav extends StatelessWidget{
  const Filternav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), 
          ),
        ],
      ),
      child: Row(
        children: [
          TextButton(
            child: Row(children: [
              SvgPicture.asset('assets/images/filter.svg',width: 24,),
              SizedBox(width: 4),
              Text('Filter', 
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.inter().fontFamily,
                color: Colors.black
              ),)
            ],), 
            onPressed: (){},
          ),
          Spacer(),
          TextButton(onPressed: (){}, child: Row(
            children: [
              Text('Sort by',  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: Colors.black
                  ),),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, color: Colors.black,)
            ],
          ),)
            

        ],
      ),
    );
  }
}