import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Items/counter.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/product/widget/select_color.dart';
import 'package:google_fonts/google_fonts.dart';


class DetailsCard extends StatefulWidget{
  const DetailsCard({
    super.key, 
 
    required this.name, 
    required this.category, 
    required this.colours, 
    required this.description,
    required this.measurements,
    required this.price,
    required this.rating,
    required this.quantity


    });

  final String name;
  final String category;
  final String description;
  final double price;
  final String measurements;
  final List<String> colours;
  final int quantity;
  final int rating;

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    int selectedqty =1;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RatingStar(initialRating: widget.rating,),
              SizedBox(width: 12,),
              Text('11 Reviews', style: TextStyle(fontSize: 12,
               fontFamily: GoogleFonts.inter().fontFamily
               ),textAlign: TextAlign.justify,)
            ],
          ),
          SizedBox(height: 5,),
          Text(
            widget.name,
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
            widget.description,
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
            'Rs ${widget.price}',
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
            widget.measurements,
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
          SelectColor(colorsNames: widget.colours,),
          SizedBox(height: 20,),
          Row(
            children: [ 
             QuantityCounter(onQuantityChanged: (value) {
            setState(() {
              selectedqty = value;
            });
          }),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: Size(w * 0.55, 45),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text('Add to cart'),
          )
        ],       
      ) ,
        ]
      )

    );
  }
}