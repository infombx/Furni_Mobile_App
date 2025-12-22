class ProductFilter {
  final String? category;
  final double minPrice;
  final double maxPrice;

  ProductFilter({
    this.category,
    required this.minPrice,
    required this.maxPrice,
  });
}
