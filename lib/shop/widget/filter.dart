import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/shop/widget/productFilter.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedCategory;
  RangeValues _currentRange = const RangeValues(0, 234);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 450,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.inter().fontFamily,
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: category.map((item) {
                  final isSelected = selectedCategory == item;
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected ? const Color.fromARGB(255, 92, 92, 92) : const Color.fromARGB(255, 0, 0, 0),
                        foregroundColor: isSelected ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedCategory =
                              selectedCategory == item ? null : item;
                        });
                      },
                      child: Text(item),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Price Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.inter().fontFamily,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Rs ${_currentRange.start.toInt()}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  "Rs ${_currentRange.end.toInt()}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            RangeSlider(
              values: _currentRange,
              min: 0,
              max: 234,
              activeColor: Colors.black,
              inactiveColor: Colors.grey.shade300,
              onChanged: (values) => setState(() => _currentRange = values),
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                fixedSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  ProductFilter(
                    category: selectedCategory,
                    minPrice: _currentRange.start,
                    maxPrice: _currentRange.end,
                  ),
                );
              },
              child: const Text('Apply Filter'),
            ),
          ],
        ),
      ),
    );
  }
}
