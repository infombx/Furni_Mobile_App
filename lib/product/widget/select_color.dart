import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectColor extends StatefulWidget {
  const SelectColor({super.key, required this.colorsNames});

  final List<String> colorsNames;

  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  final Map<String, Color> colorMap = {
    'black': Colors.black,
    'grey': Colors.grey,
    'red': Colors.red,
    'white': Colors.white,
  };

  late Color selectedColor;
  late String selectedColorName;

  @override
  void initState() {
    super.initState();

    if (widget.colorsNames.isNotEmpty) {
      selectedColorName = widget.colorsNames.first;
      selectedColor =
          colorMap[selectedColorName.toLowerCase()] ?? Colors.black;
    }
  }

  Color getColorFromName(String name) {
    return colorMap[name.toLowerCase()] ?? Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    /// ✅ HIDE COMPLETELY IF NO COLORS
    if (widget.colorsNames.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedColorName,
          style: TextStyle(
            fontSize: 20,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
        const SizedBox(height: 8),

        Wrap(
          spacing: 15,
          children: widget.colorsNames.map((name) {
            final color = getColorFromName(name);

            if (color == Colors.transparent) {
              return const SizedBox.shrink();
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = color;
                  selectedColorName = name;
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
                        : const Color.fromARGB(40, 29, 29, 29),
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
