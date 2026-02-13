import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sortby extends StatefulWidget {
  final String initialSelectedSort;

  const Sortby({super.key, this.initialSelectedSort = 'C'});

  @override
  State<Sortby> createState() => _SortbyState();
}

class _SortbyState extends State<Sortby> {
  late String _selectedSort;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.initialSelectedSort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header with Title and Close Icon ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sort by',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context), // close bottom sheet
              ),
            ],
          ),
          const SizedBox(height: 10),

          // --- Radio Options ---
          RadioListTile<String>(
            title: const Text('Cheapest'),
            value: 'C',
            groupValue: _selectedSort,
            onChanged: (val) {
              setState(() => _selectedSort = val!);
              Navigator.pop(context, val);
            },
          ),
          RadioListTile<String>(
            title: const Text('Most Expensive'),
            value: 'D',
            groupValue: _selectedSort,
            onChanged: (val) {
              setState(() => _selectedSort = val!);
              Navigator.pop(context, val);
            },
          ),
          RadioListTile<String>(
            title: const Text('Newest'),
            value: 'B',
            groupValue: _selectedSort,
            onChanged: (val) {
              setState(() => _selectedSort = val!);
              Navigator.pop(context, val);
            },
          ),
          RadioListTile<String>(
            title: const Text('Oldest'),
            value: 'A',
            groupValue: _selectedSort,
            onChanged: (val) {
              setState(() => _selectedSort = val!);
              Navigator.pop(context, val);
            },
          ),
          SizedBox(height: 40)
        ],
      ),
    );
  }
}
