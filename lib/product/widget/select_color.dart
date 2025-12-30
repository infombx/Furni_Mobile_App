import 'package:flutter/material.dart';
// google_fonts not required here

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
  'orange': Colors.orange,
  'brown': Colors.brown,
  'dark grey': const Color(0xFF333333),
  'beige': const Color(0xFFF5F5DC),
  'yellow': Colors.yellow,
  'blue': Colors.blue,
  'walnut': const Color(0xFF5D4037),    
  'teak': const Color(0xFF8D6E63),    
  'mocha': const Color(0xFF4E342E),      
  'cherry': const Color(0xFF7B1F1F),   
  'oak': const Color(0xFFBC8F8F),         
  'antique light': const Color(0xFFD2B48C), 
  'antique nyatuh': const Color(0xFF6B4226), 
  'off-white': const Color(0xFFFAF9F6),
  'light blue': Colors.lightBlue,
};
  late String selectedColorName;

  @override
  void initState() {
    super.initState();
    selectedColorName = widget.colorsNames.isNotEmpty
        ? widget.colorsNames.first
        : "";
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
                    color: isSelected
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.3),
                    width: isSelected ? 3 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ]
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
