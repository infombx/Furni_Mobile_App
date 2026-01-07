import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/services/api_dummydata.dart';
import 'package:furni_mobile_app/shop/widget/filternav.dart';
import 'package:furni_mobile_app/shop/widget/grid.dart';
import 'package:furni_mobile_app/shop/widget/productFilter.dart';
import 'package:furni_mobile_app/shop_page/hero_section.dart';

// Assuming Product model is in this path
import 'package:furni_mobile_app/product/data/dummyData.dart'; 

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

  // Mapping filter display names to actual product categories from API
  final Map<String, List<String>> categoryMapping = {
    'Bedroom': ['bed', 'wardrobe'],
    'Living Room': ['sofa', 'chair', 'tv furniture', 'table'],
    'Kitchen': ['kitchen furniture', 'table'],
    'Office': ['office furniture', 'desk', 'chair', 'general'],
    'Outdoor': ['outdoor furniture'],
    'Bathroom': ['doors'],
  };

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
          String target = widget.selectedCategory!.toLowerCase().replaceAll('bundle', '').trim();
          _filteredProducts = _allProducts.where((p) {
            String productCat = p.category.toLowerCase().trim();
            String productName = p.name.toLowerCase().trim();
            return productCat.contains(target) || productName.contains(target);
          }).toList();
          if (_filteredProducts.isEmpty) _filteredProducts = List.from(products);
        } else {
          _filteredProducts = List.from(products);
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
        final productCategory = (product.category).trim().toLowerCase();

        bool categoryMatch = true;
        // Check if user selected categories in the BottomSheet
        if (filter.categories != null && filter.categories!.isNotEmpty) {
          categoryMatch = false;
          for (var selectedName in filter.categories!) {
            final mappedList = categoryMapping[selectedName] ?? [selectedName.toLowerCase()];
            if (mappedList.any((m) => m.toLowerCase() == productCategory)) {
              categoryMatch = true;
              break;
            }
          }
        }

        final priceMatch = product.price >= filter.minPrice && product.price <= filter.maxPrice;
        return categoryMatch && priceMatch;
      }).toList();
    });
  }

  void _applySort(String criteria) {
    setState(() {
      if (criteria == 'C') _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      else if (criteria == 'D') _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      else if (criteria == 'B') _filteredProducts.sort((a, b) => b.id.compareTo(a.id));
      else if (criteria == 'A') _filteredProducts.sort((a, b) => (b.id).compareTo(a.id)); // Replace with rating if available
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Header(), automaticallyImplyLeading: false, backgroundColor: Colors.white, elevation: 0),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: Color(0xFF06356B)))
        : SingleChildScrollView(
            child: Column(
              children: [
                const HeroSection(),
                Filternav(onFilterApplied: _applyFilter, onSortApplied: _applySort),
                const SizedBox(height: 10),
                _filteredProducts.isEmpty 
                  ? const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 60), child: Text("No products match this selection.")))
                  : ProductGrid(items: _filteredProducts), 
                const SizedBox(height: 120),
              ],
            ),
          ),
      bottomNavigationBar: const SizedBox(height: 100, child: GlassFloatingNavBar(currentIndex: 1)),
    );
  }
}