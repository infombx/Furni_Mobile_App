import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final String baseUrl = "http://159.65.15.249:1337";

  /// STEP 5: FETCH LOGGED-IN USER
  Future<Map<String, dynamic>?> fetchMe() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');

    if (jwt == null) return null;

    final response = await http.get(
      Uri.parse('$baseUrl/api/users/me'),
      headers: {'Authorization': 'Bearer $jwt'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }

  /// LOGOUT (optional but recommended)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.remove('userId');
  }
}
