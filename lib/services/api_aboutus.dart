import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:furni_mobile_app/home_page/data/aboutUs.dart';

class ApiService {
  static const String baseUrl = "http://159.65.15.249:1337";

  static Future<AboutData?> fetchAboutSection() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/home-page?populate[blocks][populate]=*'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final List<dynamic> blocks = body['data']['blocks'] ?? [];

        // Identify the correct block by its component name
        final aboutBlock = blocks.firstWhere(
          (block) => block['__component'] == "blocks.about-section",
          orElse: () => null,
        );

        return aboutBlock != null ? AboutData.fromJson(aboutBlock) : null;
      }
    } catch (e) {
      debugPrint("About Section Error: $e");
    }
    return null;
  }
}