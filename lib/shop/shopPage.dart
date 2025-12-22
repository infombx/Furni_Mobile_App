import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';
import 'package:furni_mobile_app/services/api_dummydata.dart';
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
  late Future<List<Product>> _productsFuture;
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService.fetchProducts();
  }

  /// APPLY FILTER FROM BOTTOM SHEET
  void _applyFilter(ProductFilter filter) {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final categoryMatch =
            filter.category == null || product.category == filter.category;

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

            // ---------------- Product Grid with API ----------------
            FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 500,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return SizedBox(
                    height: 500,
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SizedBox(
                    height: 500,
                    child: Center(child: Text('No products found')),
                  );
                }

                // ✅ API data loaded
                final products = snapshot.data!;

                // Initialize lists if empty
                if (_allProducts.isEmpty) _allProducts = products;
                if (_filteredProducts.isEmpty) _filteredProducts = products;

                return SizedBox(
                  height: 500,
                  child: ProductGrid(items: _filteredProducts),
                );
              },
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
