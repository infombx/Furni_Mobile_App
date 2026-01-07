import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactMessageService {
  static const String baseUrl = 'http://159.65.15.249:1337/api';

  static Future<bool> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    final url = Uri.parse('$baseUrl/contact-messages');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "data": {"name": name, "email": email, "message": message},
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
