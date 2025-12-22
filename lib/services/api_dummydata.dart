import 'dart:convert';
import 'package:furni_mobile_app/product/data/dummyData.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = "http://159.65.15.249:1337";

static Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('$baseUrl/api/products?populate=*'));

 if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    final List data = body['data'];
    // Pass 'e' directly because your JSON does not have an 'attributes' wrapper
    return data.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
 
}
