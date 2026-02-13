import 'package:flutter/foundation.dart';
class ReviewWeb {
  final int id;
  final String name;
  final String comment;
  final int rating;
  final DateTime date;
  final String pictureUrl;
  final String productId;

  ReviewWeb({
    required this.id,
    required this.name,
    required this.comment,
    required this.rating,
    required this.date,
    required this.pictureUrl,
    required this.productId,
  });

  factory ReviewWeb.fromJson(Map<String, dynamic> json) {
    const String baseUrl = "http://159.65.15.249:1337";
    const String placeholder = 'https://via.placeholder.com/150';
    
    // Get the data map (Strapi v4/v5 handles)
    final data = json['attributes'] ?? json;

    // --- Safe Image URL Parsing ---
    String finalUrl = placeholder;
    try {
      if (data['pfp'] != null) {
        var pfp = data['pfp'];
        String? relUrl;

        if (pfp is Map && pfp['data'] != null) {
          var pfpAttr = pfp['data']['attributes'] ?? pfp['data'];
          relUrl = pfpAttr['url']?.toString();
        } else if (pfp is Map && pfp['url'] != null) {
          relUrl = pfp['url']?.toString();
        } else if (pfp is String && pfp.isNotEmpty) {
          relUrl = pfp;
        }

        if (relUrl != null) {
          finalUrl = relUrl.startsWith('http') ? relUrl : "$baseUrl$relUrl";
        }
      }
    } catch (e) {
      debugPrint("❌ Error parsing image URL: $e");
    }

    return ReviewWeb(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: data['name']?.toString() ?? 'Anonymous',
      comment: data['Comment']?.toString() ?? '',
      rating: int.tryParse(data['rating']?.toString() ?? '0') ?? 0,
      date: data['Date'] != null ? DateTime.parse(data['Date'].toString()) : DateTime.now(),
      pictureUrl: finalUrl,
      productId: data['productId']?.toString() ?? '',
    );
  }
}
