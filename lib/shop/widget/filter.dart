import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/shop/widget/productFilter.dart';
import 'package:furni_mobile_app/shop/model/category_model.dart';
import 'package:furni_mobile_app/services/category_service.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  CategoryModel? selectedCategory;
  List<CategoryModel> categories = [];
  bool isLoading = true;

  RangeValues _currentRange = const RangeValues(0, 234);
  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final result = await CategoryService.fetchCategories();

      // DEBUG: print fetched category names
      print('Categories fetched: ${result.map((e) => e.name).toList()}');

      setState(() {
        categories = result;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        categories = [];
        isLoading = false;
      });
    }
  }

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
            // Header
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

            // Category Label
            Text(
              'Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.inter().fontFamily,
              ),
            ),

            const SizedBox(height: 20),

            // Category List
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: isLoading
                    ? [const CircularProgressIndicator()]
                    : categories.isEmpty
                    ? [
                        const Text(
                          'No categories found',
                          style: TextStyle(fontSize: 16),
                        ),
                      ]
                    : categories.map((item) {
                        final isSelected = selectedCategory?.id == item.id;

                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? Colors.yellow
                                  : Colors.black,
                              foregroundColor: isSelected
                                  ? Colors.black
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedCategory = isSelected ? null : item;
                              });
                            },
                            child: Text(item.name),
                          ),
                        );
                      }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Price Range
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
              max: 10000,
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
                    category: selectedCategory?.name,
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
