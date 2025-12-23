import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furni_mobile_app/shop/widget/filter.dart';
import 'package:furni_mobile_app/shop/widget/sortby.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/shop/widget/productFilter.dart';

class Filternav extends StatelessWidget {
  final Function(ProductFilter) onFilterApplied;

  const Filternav({super.key, required this.onFilterApplied});

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
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 3),
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (ctx) => const FilterBottomSheet(),
              );

              if (result != null) {
                onFilterApplied(result);
              }
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/images/filter.svg', width: 24),
                const SizedBox(width: 4),
                Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          TextButton(
            onPressed: () {
              showBottomSheet(context: context, 
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
              builder: (ctx) => const Sortby(),);
            },
            child: Row(
              children: [
                Text(
                  'Sort by',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

