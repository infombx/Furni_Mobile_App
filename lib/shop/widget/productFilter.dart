class ProductFilter {
  final List<String> categories;
  final double minPrice;
  final double maxPrice;

  ProductFilter({
    required this.categories,
    required this.minPrice,
    required this.maxPrice,
  });
}