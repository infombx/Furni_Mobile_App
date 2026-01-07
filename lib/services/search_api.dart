import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furni_mobile_app/models/product.dart';

class ProductService {
  final String baseUrl = 'http://159.65.15.249:1337';

  Future<List<Product>> searchProducts(String keyword) async {
    if (keyword.isEmpty) return [];

    final url = Uri.parse(
      '$baseUrl/api/products?populate=*&filters[title][\$containsi]=$keyword',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List list = jsonData['data'] ?? [];

      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }
}