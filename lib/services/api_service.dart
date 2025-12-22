import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "http://159.65.15.249:1337";

  Future<List<dynamic>> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt');

    final url = Uri.parse(
      "$baseUrl/api/products",
    ); // Your content type endpoint
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']; // Strapi wraps results in 'data'
    } else {
      print('Error fetching data: ${response.body}');
      return [];
    }
  }
}
