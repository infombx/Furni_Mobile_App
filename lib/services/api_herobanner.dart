import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:furni_mobile_app/home_page/data/hero_banner_section.dart';

class ApiService {
  static const String baseUrl = "http://159.65.15.249:1337";

  static Future<List<HeroBannerSection>> fetchHeroBanners() async {
    try {
      // Deep populate: specifically asks for SliderImage inside the Slide component
      final response = await http.get(
        Uri.parse('$baseUrl/api/hero-section?populate[Slide][populate]=SliderImage'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        
        // In Strapi "Single Types", the data is often directly under data['Slide']
        final List<dynamic> slideData = body['data']['Slide'] ?? [];

        return slideData
            .map((json) => HeroBannerSection.fromJson(json))
            .toList();
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("HeroBanner API Error: $e");
      return [];
    }
  }
}