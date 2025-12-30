import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furni_mobile_app/home_page/data/bundle.dart';

class ApiService {
  static const String baseUrl = "http://159.65.15.249:1337";

  static Future<List<BundleModel>> fetchBundles() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/home-page?populate[blocks][populate]=*'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List<dynamic> blocks = body['data']['blocks'] ?? [];

      // Only return blocks that are categories
      return blocks
          .where((block) => block['__component'] == "blocks.category")
          .map((item) => BundleModel.fromJson(item))
          .toList();
    } else {
      throw Exception("Failed to load: ${response.statusCode}");
    }
  }
}