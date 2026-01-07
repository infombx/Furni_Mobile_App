import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactPageService {
  static const String baseUrl = 'http://159.65.15.249:1337/api';

  static Future<List<dynamic>> fetchBlocks() async {
    final uri = Uri.parse(
      '$baseUrl/pages'
      '?filters[slug][\$eq]=contact-us'
      '&populate[blocks][populate]=*',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load Contact Us page');
    }

    final jsonData = json.decode(response.body);
    final data = jsonData['data'] as List;

    if (data.isEmpty) return [];

    return data.first['blocks'] ?? [];
  }
}
