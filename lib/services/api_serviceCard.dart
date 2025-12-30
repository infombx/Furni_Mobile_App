import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furni_mobile_app/contactUs/data/servicesData.dart';

class ApiService {
  static const String baseUrl = "http://159.65.15.249:1337";

  static Future<List<ServiceCard>> fetchServices() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/home-page?populate[blocks][populate]=*'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      
      // Strapi 5 deep nesting: data -> blocks
      final List<dynamic> blocks = body['data']['blocks'] ?? [];

      // Filter for only the 'blocks.card' components
      return blocks
          .where((block) => block['__component'] == "blocks.card")
          .map((item) => ServiceCard.fromJson(item))
          .toList();
    } else {
      throw Exception("Failed to load services from Strapi");
    }
  }
}