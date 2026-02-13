import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/shop/widget/productFilter.dart';
import 'package:teakworld/shop/model/category_model.dart';
import 'package:teakworld/services/category_service.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<CategoryModel> initialSelectedCategories;
  final RangeValues initialRange;

  const FilterBottomSheet({
    super.key,
    this.initialSelectedCategories = const [],
    this.initialRange = const RangeValues(0, 100000),
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<CategoryModel> selectedCategories = [];
  List<CategoryModel> categories = [];
  bool isLoading = true;
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();
    // Initialize with previous selection
    selectedCategories = List.from(widget.initialSelectedCategories);
    _currentRange = widget.initialRange;
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final result = await CategoryService.fetchCategories();
      if (mounted) {
        setState(() {
          categories = result;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          categories = [];
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 480,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header ---
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

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // --- Category Label ---
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Category List ---
                  SizedBox(
                    height: 45,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : categories.isEmpty
                        ? const Text('No categories found')
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final item = categories[index];
                              final isSelected = selectedCategories.any(
                                (c) => c.id == item.id,
                              );

                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSelected
                                        ? Colors.black
                                        : Colors.white,
                                    foregroundColor: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedCategories.removeWhere(
                                          (c) => c.id == item.id,
                                        );
                                      } else {
                                        selectedCategories.add(item);
                                      }
                                    });
                                  },
                                  child: Text(item.name),
                                ),
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 30),

                  // --- Price Range Label ---
                  Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Price Display ---
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

                  // --- Range Slider ---
                  RangeSlider(
                    values: _currentRange,
                    min: 0,
                    max: 100000,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey.shade300,
                    onChanged: (values) {
                      setState(() => _currentRange = values);
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // --- Apply Button ---
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              Navigator.pop(
                context,
                ProductFilter(
                  categories: selectedCategories.map((e) => e.name).toList(),
                  minPrice: _currentRange.start,
                  maxPrice: _currentRange.end,
                  selectedCategoryModels: selectedCategories,
                ),
              );
            },
            child: const Text('Apply Filter'),
          ),
          SizedBox(height: 40)
        ],
      ),
    );
  }
}
