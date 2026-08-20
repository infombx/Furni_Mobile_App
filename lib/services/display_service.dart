import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> fetchDisplayName() async {
  const String baseUrl = "http://159.65.15.249:1337";
  final prefs = await SharedPreferences.getInstance();
  final jwt = prefs.getString('jwt');

  if (jwt == null) return null;

  final response = await http.get(
    Uri.parse('$baseUrl/api/users/me'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['username']; // or data['fullName'] if you added one
  }

  return null;
}
