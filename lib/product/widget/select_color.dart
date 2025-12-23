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
  // Original Colors
  'black': Colors.black,
  'grey': Colors.grey,
  'red': Colors.red,
  'white': Colors.white,
  'orange': Colors.orange, 
  'brown': Colors.brown,

  // Additional common furniture colors
  'blue': Colors.blue,
  'green': Colors.green,
  'pink': Colors.pink,
  'yellow': Colors.yellow,
  'amber': Colors.amber,
  'beige': const Color(0xFFF5F5DC), // Custom hex for Beige
  'off-white': const Color(0xFFFAF9F6), // Matches your "Off-white Pillow"
  'dark grey': const Color(0xFF333333),
  'light blue': Colors.lightBlue,
};
  late String selectedColorName;

  @override
  void initState() {
    super.initState();
    selectedColorName = widget.colorsNames.isNotEmpty ? widget.colorsNames.first : "";
  }

  @override
  Widget build(BuildContext context) {
    if (widget.colorsNames.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
              selectedColorName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: widget.colorsNames.map((name) {
            final colorValue = colorMap[name.toLowerCase()] ?? Colors.grey;
            final isSelected = selectedColorName == name;

            return GestureDetector(
              onTap: () => setState(() => selectedColorName = name),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorValue,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.3),
                    width: isSelected ? 3 : 1,
                  ),
                  boxShadow: isSelected 
                      ? [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))] 
                      : [],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}