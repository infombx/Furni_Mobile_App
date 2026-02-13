import 'package:teakworld/shop/model/category_model.dart';

class ProductFilter {
  final List<String> categories;
  final double minPrice;
  final double maxPrice;

  final List<CategoryModel> selectedCategoryModels;

  ProductFilter({
    required this.categories,
    required this.minPrice,
    required this.maxPrice,
    this.selectedCategoryModels = const [],
  });
}
