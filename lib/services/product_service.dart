import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teakworld/models/product_model.dart';

class ProductService {
  final String baseUrl = "http://159.65.15.249:1337";

  /// ======================
  /// FETCH PRODUCTS
  /// ======================
  Future<List<Product>> fetchProducts() async {
    try {
      final url = Uri.parse('$baseUrl/api/products?populate=*');

      final response = await http.get(url);

      print('📦 PRODUCTS STATUS: ${response.statusCode}');
      print('📦 PRODUCTS BODY: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final List list = decoded['data'];

        return list.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('❌ PRODUCT ERROR: $e');
      rethrow;
    }
  }
}
