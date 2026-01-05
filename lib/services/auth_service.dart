import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:furni_mobile_app/models/user_model.dart';

class AuthService {
  final String baseUrl = "http://159.65.15.249:1337";


  Future<AppUser?> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/local/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': email,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      // Save JWT and userId in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', data['jwt']);
      await prefs.setInt('userId', data['user']['id']);

      // Create AppUser and assign JWT
      final user = AppUser.fromJson(data['user']);
      user.jwtToken = data['jwt'];
      return user;
    }

    return null;
  }
  
  Future<AppUser?> signIn(String identifier, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/local'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', data['jwt']);
      await prefs.setInt('userId', data['user']['id']);

      final user = AppUser.fromJson(data['user']);
      user.jwtToken = data['jwt'];
      return user;
    }

    return null;
  }

  /// ======================
  /// FETCH LOGGED-IN USER
  /// ======================
  Future<AppUser?> fetchMe() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');

    if (jwt == null) return null;

    final response = await http.get(
      Uri.parse('$baseUrl/api/users/me?populate=profilePicture'),
      headers: {'Authorization': 'Bearer $jwt'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final user = AppUser.fromJson(data);
      user.jwtToken = jwt;
      return user;
    }

    return null;
  }

  /// ======================
  /// LOGOUT USER
  /// ======================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.remove('userId');
  }
}
