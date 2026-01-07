import 'package:flutter/material.dart';
import 'package:furni_mobile_app/home_page/shopNow_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class Shopnow extends StatelessWidget {
  final Map<String, dynamic> block;

  const Shopnow({super.key, required this.block});

  String parseRichText(List<dynamic>? content) {
    if (content == null) return '';

    return content
        .map((block) {
          final children = block['children'] as List<dynamic>?;
          if (children == null) return '';
          return children.map((c) => c['text'] ?? '').join('');
        })
        .join('\n\n');
  }

  String? resolveImageUrl(Map<String, dynamic>? image) {
    if (image == null) return null;

    if (image['url'] != null) {
      return 'http://159.65.15.249:1337${image['url']}';
    }

    final data = image['data'];
    if (data != null && data['attributes'] != null) {
      return 'http://159.65.15.249:1337${data['attributes']['url']}';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final String heading = block['heading'] ?? '';
    final String description = parseRichText(
      block['content'] as List<dynamic>?,
    );

    final String? imageUrl = resolveImageUrl(block['image']);

    return Column(
      children: [
        if (imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: Image.network(
              imageUrl,
              width: 311,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 80),
            ),
          ),

        Container(
          width: 310,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                heading,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              const ShopNowLink(),
            ],
          ),
        ),
      ],
    );
  }
}
