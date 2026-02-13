import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teakworld/shop/widget/filter.dart';
import 'package:teakworld/shop/widget/sortby.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/shop/widget/productFilter.dart';
import 'package:teakworld/shop/model/category_model.dart';

class Filternav extends StatelessWidget {
  final Function(ProductFilter) onFilterApplied;
  final Function(String) onSortApplied;
  final String selectedSort; // 🔥 add this

  final List<CategoryModel> selectedCategories;
  final RangeValues currentRange;

  const Filternav({
    super.key,
    required this.onFilterApplied,
    required this.onSortApplied,
    required this.selectedCategories,
    required this.currentRange,
    required this.selectedSort,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () async {
              final result = await showModalBottomSheet<ProductFilter>(
                context: context,
                isScrollControlled: true,
                builder: (_) => FilterBottomSheet(
                  initialSelectedCategories: selectedCategories,
                  initialRange: currentRange,
                ),
              );
              if (result != null) onFilterApplied(result);
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/images/filter.svg', width: 20),
                const SizedBox(width: 8),
                Text(
                  'Filter',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () async {
              // Open the Sortby bottom sheet while passing the previously selected sort
              final String? result = await showModalBottomSheet<String>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (ctx) => Sortby(
                  initialSelectedSort:
                      selectedSort, // pass the current selection
                ),
              );

              if (result != null) onSortApplied(result); // trigger callback
            },
            child: Row(
              children: [
                Text(
                  'Sort by',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
