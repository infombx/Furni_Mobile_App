import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> updateProfileOnStrapi({
  required String userId,
  required String firstName,
  required String lastName,
  required String displayName,
  required String jwtToken,
}) async {
  final url = Uri.parse('http://159.65.15.249:1337/api/users/$userId');

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwtToken',
    },
    body: jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
    }),
  );

  if (response.statusCode == 200) {
    return true; // Success
  } else {
    print('Error updating profile: ${response.body}');
    return false;
  }
}
