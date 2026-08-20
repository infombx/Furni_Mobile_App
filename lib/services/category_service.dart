
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../shop/model/category_model.dart';

class CategoryService {
  static const String baseUrl =
      'http://159.65.15.249:1337/api/product-categories';

  static Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse(baseUrl));

    print('🟢 Category API status: ${response.statusCode}');
    print('🟢 Category API body: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      final List list = decoded['data'] ?? [];

      if (list.isEmpty) {
        print('⚠️ No categories returned from Strapi');
      }

      return list.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('❌ Failed to load categories');
    }
  }
}
