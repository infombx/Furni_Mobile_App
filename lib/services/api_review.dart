import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:furni_mobile_app/product/data/reviewdata.dart';

class ReviewService {
  final String apiUrl = "http://159.65.15.249:1337/api/review-webs";

  Future<List<ReviewWeb>> fetchReviewWebs({String? productId}) async {
    // Use clear filters and ensure no double symbols
    String url = "$apiUrl?populate=*";
    if (productId != null && productId.isNotEmpty) {
      url += "&filters[productId][\$eq]=${productId.trim()}";
    }

    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List list = decoded['data'] ?? [];
        return list.map((e) => ReviewWeb.fromJson(e)).toList();
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } on SocketException {
      throw Exception("No Internet connection or Server unreachable");
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

Future<void> postReview({
  required String name,
  required String comment,
  required int rating,
  required int productId,
  required int? pfpId,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('jwt');

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "data": {
          "name": name,
          "Comment": comment,
          "rating": rating,
          "productId": productId,
          "pfp": pfpId,
          "Date": DateTime.now().toIso8601String(), // Ensure date is sent
        }
      }),
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode != 200 && response.statusCode != 201) {
      // This will tell us if it's a 403 (Forbidden) or 400 (Bad Request)
      throw "Server returned ${response.statusCode}: ${response.body}";
    }
  } on SocketException {
    throw "No internet or server IP unreachable. Check if your server firewall allows port 1337.";
  } catch (e) {
    throw e.toString();
  }
}
}