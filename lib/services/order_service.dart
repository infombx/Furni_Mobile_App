import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  final String baseUrl = 'http://159.65.15.249:1337';

  Future<void> createOrder({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String street,
    required String country,
    required String city,
    required String state,
    required String zip,
  }) async {
    final url = Uri.parse('$baseUrl/api/orders');

    final body = {
      "data": {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "street": street,
        "country": country,
        "city": city,
        "state": state,
        "zip": zip,
      },
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print('📦 ORDER STATUS: ${response.statusCode}');
    print('📦 ORDER BODY: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('failed to create order');
    }
  }
}
