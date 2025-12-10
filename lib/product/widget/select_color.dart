import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectColor extends StatefulWidget {
  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {


  Color selectedColor = Color.fromARGB(255, 0, 0, 0);
  String selectedColorName = "Black";


  final List<Color> colors = [
    const Color.fromARGB(255, 0, 0, 0),     
    const Color.fromARGB(255, 221, 210, 163),
    const Color.fromARGB(255, 197, 0, 0),    
    const Color.fromARGB(255, 233, 233, 233),
  ];

  final List<String> colorNames = [
    "Black",
    "Cream",
    "Red",
    "Gray"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedColorName.isNotEmpty ? selectedColorName : "Black",
          style: TextStyle(
            fontSize: 20,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),

        SizedBox(height: 8),
        Wrap(
          spacing: 15,
          children: List.generate(colors.length, (index) {
            final color = colors[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = color;
                  selectedColorName = colorNames[index]; 
                });
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border: Border.all(
                    color: selectedColor == color
                        ? const Color.fromARGB(255, 113, 113, 113)
                        : const Color.fromARGB(21, 29, 29, 29),
                    width: 2,
                  ),
                ),
              ),
            );
          }),
        ),

      ],
    );
  }
}
