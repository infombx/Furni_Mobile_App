import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://159.65.15.249:1337";

  /// ======================
  /// LOGIN USER
  /// ======================
  Future<bool> signIn(String identifier, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/local');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier, 'password': password}),
    );

    print('LOGIN STATUS: ${response.statusCode}');
    print('LOGIN BODY: ${response.body}');

    if (response.statusCode == 200) {
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
