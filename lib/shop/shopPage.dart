import 'package:flutter/material.dart';
import 'package:teakworld/Header/header.dart';
import 'package:teakworld/navbar/navbar.dart';
import 'package:teakworld/services/api_dummydata.dart';
import 'package:teakworld/shop/widget/filternav.dart';
import 'package:teakworld/shop/widget/grid.dart';
import 'package:teakworld/shop/widget/productFilter.dart';
import 'package:teakworld/shop_page/hero_section.dart';
import 'package:teakworld/product/data/dummyData.dart';
import 'package:teakworld/shop/model/category_model.dart';

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

  String _selectedSort = 'C';

  // Persistent selection
  List<CategoryModel> _selectedCategories = [];
  RangeValues _currentRange = const RangeValues(0, 100000);

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
        _filteredProducts = List.from(products);
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _applyFilter(ProductFilter filter) {
    setState(() {
      _selectedCategories = filter.selectedCategoryModels;
      _currentRange = RangeValues(filter.minPrice, filter.maxPrice);

      _filteredProducts = _allProducts.where((product) {
        final productCategory = product.category.toLowerCase().trim();

        bool categoryMatch = _selectedCategories.isEmpty;

        if (_selectedCategories.isNotEmpty) {
          for (final selected in _selectedCategories) {
            final mappedList =
                categoryMapping[selected.name] ?? [selected.name.toLowerCase()];

            if (mappedList.any((m) => m == productCategory)) {
              categoryMatch = true;
              break;
            }
          }
        }

        final priceMatch =
            product.price >= filter.minPrice &&
            product.price <= filter.maxPrice;

        return categoryMatch && priceMatch;
      }).toList();
    });
  }

  void _applySort(String criteria) {
    setState(() {
      _selectedSort = criteria;
      if (criteria == 'C') {
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      } else if (criteria == 'D') {
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      } else if (criteria == 'B') {
        _filteredProducts.sort((a, b) => b.id.compareTo(a.id));
      } else if (criteria == 'A') {
        _filteredProducts.sort((a, b) => b.id.compareTo(a.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Header(),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(1, 100, 109, 1),
        elevation: 0,
      ),
      body: Stack(
        children: [
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF06356B)),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const HeroSection(),
                      Filternav(
                        selectedCategories: _selectedCategories,
                        currentRange: _currentRange,
                        selectedSort: _selectedSort,
                        onFilterApplied: _applyFilter,
                        onSortApplied: _applySort,
                      ),
                      const SizedBox(height: 10),
                      _filteredProducts.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 60),
                                child: Text(
                                  "No products match this selection.",
                                ),
                              ),
                            )
                          : ProductGrid(items: _filteredProducts),
                      const SizedBox(height: 100), // Space for navbar
                    ],
                  ),
                ),

          // Floating Glass Navbar
          const GlassFloatingNavBar(currentIndex: 1),
        ],
      ),
    );
  }
}
