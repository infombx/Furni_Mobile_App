import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';
import 'package:furni_mobile_app/shop/widget/filternav.dart';
import 'package:furni_mobile_app/shop/widget/grid.dart';
import 'package:furni_mobile_app/shop/widget/productFilter.dart';
import 'package:furni_mobile_app/shop_page/hero_section.dart';

class Shoppage extends StatefulWidget {
  const Shoppage({super.key});

  @override
  State<Shoppage> createState() => _ShoppageState();
}

class _ShoppageState extends State<Shoppage> {
  late final List<Product> _allProducts;
  late List<Product> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _allProducts = dummyProducts;
    _filteredProducts = dummyProducts;
  }

  /// APPLY FILTER FROM BOTTOM SHEET
  void _applyFilter(ProductFilter filter) {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final categoryMatch =
            filter.category == null ||
            product.category == filter.category;

        final priceMatch =
            product.price >= filter.minPrice &&
            product.price <= filter.maxPrice;

        return categoryMatch && priceMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Header(),
        automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 4),
            const HeroSection(),
            Filternav(
              onFilterApplied: _applyFilter,
            ),

            const SizedBox(height: 6),
            SizedBox(
              height:500,
              child: ProductGrid(
                items: _filteredProducts,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 90,
        child: GlassFloatingNavBar(),
      ),
    );
  }
}
