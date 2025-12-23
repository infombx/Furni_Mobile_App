import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furni_mobile_app/product/data/dummyData.dart'; // Your Product Model
import 'package:furni_mobile_app/shop/data/category_model.dart'; // Category Model

class ApiService {
  static const String baseUrl = "http://159.65.15.249:1337";

  /// 1. Fetch all products (with Category and Image relations populated)
  static Future<List<Product>> fetchProducts() async {
    try {
      // populate=* ensures images and categories are included in the JSON response
      final response = await http.get(
        Uri.parse('$baseUrl/api/products?populate=*'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        
        // Convert the list of JSON objects into a list of Product models
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        // Specifically catch server-side errors (404, 500, etc)
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      // Catches network issues, decoding errors, or manual exceptions thrown above
      throw Exception("Failed to fetch products: $e");
    }
  }

  /// 2. Fetch all categories for the Filter Bottom Sheet
  static Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/product-categories'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final List<dynamic> data = body['data'];
        
        return data.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load categories: $e");
    }
  }
}