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
  final String? selectedCategory;
  const Shoppage({super.key, this.selectedCategory});

  @override
  State<Shoppage> createState() => _ShoppageState();
}

class _ShoppageState extends State<Shoppage> {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAndInitProducts();
  }

  Future<void> _fetchAndInitProducts() async {
    try {
      final products = await ApiService.fetchProducts();
      if (!mounted) return;

      setState(() {
        _allProducts = products;
        
        if (widget.selectedCategory != null && widget.selectedCategory!.isNotEmpty) {
          // Clean "Living Room Bundle" -> "living room"
          String target = widget.selectedCategory!
              .toLowerCase()
              .replaceAll('bundle', '')
              .trim();
          
          _filteredProducts = _allProducts.where((p) {
            String prodCat = p.category.toLowerCase().trim();
            // Match if category name matches or is contained
            return prodCat.contains(target) || target.contains(prodCat);
          }).toList();

          // Fallback if no match found
          if (_filteredProducts.isEmpty) _filteredProducts = products;
        } else {
          _filteredProducts = products;
        }
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _applyFilter(ProductFilter filter) {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final categoryMatch = filter.category == null || 
                              product.category == filter.category;
        final priceMatch = product.price >= filter.minPrice && 
                           product.price <= filter.maxPrice;
        return categoryMatch && priceMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Header(), automaticallyImplyLeading: true),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                const HeroSection(),
                Filternav(onFilterApplied: _applyFilter),
                // Important: ProductGrid has shrinkWrap: true, so no SizedBox needed
                ProductGrid(items: _filteredProducts), 
                const SizedBox(height: 100),
              ],
            ),
          ),
      bottomNavigationBar: const SizedBox(height: 90, child: GlassFloatingNavBar()),
    );
  }
}
