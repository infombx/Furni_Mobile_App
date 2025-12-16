import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/shop/data/dummy.dart';

class Sortby extends StatefulWidget {
  const Sortby({super.key});

  @override
  State<Sortby> createState() => _SortbyState();
}

class _SortbyState extends State<Sortby> {
  String sortby = 'A';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 400, 
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(onPressed:(){ Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 15,)),
                Text('Sort by', style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  color: Colors.black,
                ),)
              ],
            ),
        SizedBox(height: 32),
         RadioListTile(
                activeColor: Colors.black,
                title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recommended',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),  
                  ],
                ),
                
                value: 'A', 
                groupValue: sortby,
                onChanged: (value) => setState(() {
                  sortby = value!;
                }),
                 visualDensity: const VisualDensity(horizontal: -4.0),
                ),
          RadioListTile(
                activeColor: Colors.black,
                title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recently Added',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),  
                  ],
                ),
                
                value: 'B', 
                groupValue: sortby,
                onChanged: (value) => setState(() {
                  sortby = value!;
                }),
                 visualDensity: const VisualDensity(horizontal: -4.0),
                ),
          RadioListTile(
                activeColor: Colors.black,
                title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price: Low to High',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),  
                  ],
                ),
                
                value: 'C', 
                groupValue: sortby,
                onChanged: (value) => setState(() {
                  sortby = value!;
                }),
                 visualDensity: const VisualDensity(horizontal: -4.0),
                ),
           RadioListTile(
                activeColor: Colors.black,
                title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price: High to Low',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),  
                  ],
                ),
                
                value: 'D', 
                groupValue: sortby,
                onChanged: (value) => setState(() {
                  sortby = value!;
                }),
                 visualDensity: const VisualDensity(horizontal: -4.0),
                ),
           RadioListTile(
                activeColor: Colors.black,
                title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Top Rated',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),  
                  ],
                ),
                
                value: 'E', 
                groupValue: sortby,
                onChanged: (value) => setState(() {
                  sortby = value!;
                }),
                 visualDensity: const VisualDensity(horizontal: -4.0),
                ),
          ],
        ),
      )
    );
  }
}