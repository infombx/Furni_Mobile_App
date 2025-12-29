import 'dart:convert';
import 'package:http/http.dart' as http;
import '../shop/model/category_model.dart';

class CategoryService {
  static const String baseUrl = 'http://localhost:1337/api/product-categories';

  static Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse(baseUrl));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['data'];
      return list.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
