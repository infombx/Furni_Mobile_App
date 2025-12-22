import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://159.65.15.249:1337";

  /// ======================
  /// REGISTER USER
  /// ======================
  Future<bool> register(String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/local/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    print('REGISTER STATUS: ${response.statusCode}');
    print('REGISTER BODY: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      final String jwt = data['jwt'];
      final int userId = data['user']['id']; // ✅ VERY IMPORTANT

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', jwt);
      await prefs.setInt('userId', userId);

      print('✅ Saved JWT & UserID: $userId');
      return true;
    }

    return false;
  }
}
