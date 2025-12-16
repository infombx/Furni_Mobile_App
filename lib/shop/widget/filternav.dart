import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furni_mobile_app/shop/widget/filter.dart';
import 'package:furni_mobile_app/shop/widget/sortby.dart';
import 'package:google_fonts/google_fonts.dart';

class Filternav extends StatelessWidget{
  const Filternav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), 
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
            onPressed: (){showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) => const FilterBottomSheet(),
            );},
          ),
          Spacer(),
          TextButton(onPressed: (){showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) => const Sortby(),
            );}, child: Row(
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