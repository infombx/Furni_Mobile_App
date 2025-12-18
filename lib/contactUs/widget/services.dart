import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Services extends StatelessWidget{
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                 decoration: BoxDecoration(
                  color: const Color.fromRGBO(243, 245, 247, 1),
                  borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.only(top:10, left:25, right:10, bottom:10),
                width: w * 0.39,  
                height: h * 0.30,
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/delivery.svg', width: 48,),
                    SizedBox(height: 16,),
                    Text('Free Shipping',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: GoogleFonts.inter().fontFamily
                    ),),
                    Text('Order above \$200',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      color: Color.fromRGBO(108, 114, 117, 1),
                    ),
                    textAlign: TextAlign.center,)
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                 decoration: BoxDecoration(
                  color: const Color.fromRGBO(243, 245, 247, 1),
                  borderRadius: BorderRadius.circular(20)
                ),
                  padding: EdgeInsets.only(top:10, left:25, right:10, bottom:10),
                width: w * 0.39,  
                height: h * 0.30,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/images/money.svg', width: 48,),
                      SizedBox(height: 16,),
                      Text('Money-back',
                       style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: GoogleFonts.inter().fontFamily
                      ),),
                      Text('30 days guarantee',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Color.fromRGBO(108, 114, 117, 1),
                      ),
                      textAlign: TextAlign.start,)
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                 decoration: BoxDecoration(
                  color: const Color.fromRGBO(243, 245, 247, 1),
                  borderRadius: BorderRadius.circular(20)
                ),
              padding: EdgeInsets.only(top:10, left:25, right:5, bottom:10),
                width: w * 0.39,  
                height: h * 0.30,
               
                  child: Center(
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/images/lock.svg', width: 48,),
                        SizedBox(height: 16,),
                        Text('Secure Payments',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: GoogleFonts.inter().fontFamily
                        ),),
                        Text('Secured by stripe',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          color: Color.fromRGBO(108, 114, 117, 1),
                        ),
                        textAlign: TextAlign.start,)
                      ],
                    ),
                  ),
                
              ),
              SizedBox(width: 10,),
      
              Container(
                 decoration: BoxDecoration(
                  color: const Color.fromRGBO(243, 245, 247, 1),
                  borderRadius: BorderRadius.circular(20)
                ),
               padding: EdgeInsets.only(top:10, left:25, right:10, bottom:10),
                width: w * 0.39,  
                height: h * 0.30,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/images/call.svg', width: 48,),
                      SizedBox(height: 16,),
                      Text('24/7 Support',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: GoogleFonts.inter().fontFamily
                      ),),
                      Text('Phone and Email support',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        color: Color.fromRGBO(108, 114, 117, 1),
                      ),
                      textAlign: TextAlign.start,)
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}