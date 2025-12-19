import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final String baseUrl = "http://159.65.15.249:1337";

  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String displayName,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwt = prefs.getString('jwt');
      final userId = prefs.getInt('userId');

      if (jwt == null || userId == null) {
        print('❌ Missing JWT or User ID');
        return false;
      }

      final url = Uri.parse('$baseUrl/api/users/$userId');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt',
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'displayName': displayName,
        }),
      );

      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      print('❌ ERROR: $e');
      return false;
    }
  }
}
