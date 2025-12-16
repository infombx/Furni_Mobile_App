import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Items/counter.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/product/widget/select_color.dart';
import 'package:google_fonts/google_fonts.dart';


class DetailsCard extends StatelessWidget{
  const DetailsCard({super.key, required this.onQuantityChanged});
  final void Function (int) onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RatingStar(),
              SizedBox(width: 12,),
              Text('11 Reviews', style: TextStyle(fontSize: 12,
               fontFamily: GoogleFonts.inter().fontFamily
               ),textAlign: TextAlign.justify,)
            ],
          ),
          SizedBox(height: 5,),
          Text(
            'Tray Table',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.4,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 5,),
          Text(
            'Buy one or buy a few and make every space where you sit more convenient. Light and easy to move around with removable tray top, handy for serving snacks.',
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 108, 109, 117),
              letterSpacing: 0,
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: 16,),
          Text(
            '\$199.00',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.poppins().fontFamily,
              letterSpacing: -0.6,
            ),
          ), 
          Divider(
            color: const Color.fromARGB(255, 108, 109, 117) ,
            thickness: 0.2,
          ),
          Text(
            'Measurements',
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 108, 109, 117),
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            '17 1/2x20 5/8 "',
            style: TextStyle(
              fontSize: 20,
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w400,
            ),
          ), 
          SizedBox(height: 24,),
                    Row(
                      children: [Text(
                                  'Choose Color ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 108, 109, 117),
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios, size: 12, color: const Color.fromARGB(255, 108, 109, 117),)
                                ]
                    ),
          SizedBox(height: 5,),
          SelectColor(),
          SizedBox(height: 20,),
          Row(
            children: [ 
              QuantityCounter(onQuantityChanged:onQuantityChanged),
              SizedBox(width: 8,),
              ElevatedButton(onPressed: (){},
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(Size(w* 0.55, 45)),
                backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 0, 0)), 
                foregroundColor: WidgetStateProperty.all(Colors.white),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ), child: Text('Add to cart'),
          )

          

        ],
        
      ) ,
        ]
      )

    );
  }
}