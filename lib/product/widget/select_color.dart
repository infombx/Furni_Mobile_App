import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectColor extends StatefulWidget {
  const SelectColor({
    super.key,
    required this.colorsNames,
    required this.onColorChanged,
    this.initialColor,
  });

  final List<String> colorsNames;
  final String? initialColor;
  final void Function(String selectedColorName) onColorChanged;

  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  final Map<String, Color> colorMap = {
    'black': Colors.black,
    'grey': Colors.grey,
    'red': Colors.red,
    'white': Colors.white,
    'orange': Colors.orange,
    'brown': Colors.brown,
    'blue': Colors.blue,
    'green': Colors.green,
    'pink': Colors.pink,
    'yellow': Colors.yellow,
    'amber': Colors.amber,
    'beige': const Color(0xFFF5F5DC),
    'off-white': const Color(0xFFFAF9F6),
    'dark grey': const Color(0xFF333333),
    'light blue': Colors.lightBlue,
  };

  late String selectedColorName;

  @override
  void initState() {
    super.initState();
    _initializeSelection();
  }

  // Handle cases where the parent changes the selection externally
  @override
  void didUpdateWidget(SelectColor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialColor != oldWidget.initialColor) {
      _initializeSelection();
    }
  }

  void _initializeSelection() {
    setState(() {
      selectedColorName = widget.initialColor ??
          (widget.colorsNames.isNotEmpty ? widget.colorsNames.first : "");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.colorsNames.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedColorName.toUpperCase(),
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: widget.colorsNames.map((name) {
            final colorValue = colorMap[name.toLowerCase().trim()] ?? Colors.grey;
            // Case-insensitive comparison
            final isSelected = selectedColorName.toLowerCase().trim() == name.toLowerCase().trim();

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColorName = name;
                });
                // THIS PASSES DATA TO DETAILS CARD
                widget.onColorChanged(name);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorValue,
                  border: Border.all(
                    color: isSelected ? const Color.fromARGB(255, 62, 62, 62) : Colors.grey.withOpacity(0.1),
                    width: isSelected ? 1.5 : 1,
                  ),
                  boxShadow: isSelected
                      ? [const BoxShadow(color: Color.fromARGB(97, 0, 0, 0), blurRadius: 7)]
                      : [],
                ),
                // child: isSelected 
                //   ? Icon(Icons.check, size: 20, color: colorValue == Colors.white ? Colors.black : Colors.white)
                //   : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
