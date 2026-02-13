import 'package:flutter/material.dart';
import 'package:teakworld/home_page/shopNow_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class Shopnow extends StatelessWidget {
  final Map<String, dynamic> block;

  const Shopnow({super.key, required this.block});

  String parseRichText(List<dynamic>? content) {
    if (content == null) return '';
    return content.map((block) {
      final children = block['children'] as List<dynamic>?;
      if (children == null) return '';
      return children.map((c) => c['text'] ?? '').join('');
    }).join('\n\n');
  }

  String? resolveImageUrl(Map<String, dynamic>? image) {
    if (image == null) return null;
    if (image['url'] != null) return 'http://159.65.15.249:1337${image['url']}';
    final data = image['data'];
    if (data != null && data['attributes'] != null) {
      return 'http://159.65.15.249:1337${data['attributes']['url']}';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final String heading = block['heading'] ?? '';
    final String description = parseRichText(block['content'] as List<dynamic>?);
    final String? imageUrl = resolveImageUrl(block['image']);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint for Desktop/Tablet
        final bool isWide = constraints.maxWidth > 700;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100), // Max width for desktop
            child: isWide 
                ? _buildWideLayout(imageUrl, heading, description) 
                : _buildMobileLayout(imageUrl, heading, description),
          ),
        );
      },
    );
  }

  // --- WIDE LAYOUT (Row: Image left, Text right) ---
  Widget _buildWideLayout(String? imageUrl, String heading, String description) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (imageUrl != null)
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
                ),
              ),
            ),
          const SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: _buildTextContainer(heading, description, isWide: true),
          ),
        ],
      ),
    );
  }

  // --- MOBILE LAYOUT (Column: Image top, Text bottom) ---
  Widget _buildMobileLayout(String? imageUrl, String heading, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: double.infinity, // Take full width of phone
              height: 250, // Fixed height for mobile image
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
            ),
          ),
        const SizedBox(height: 12),
        _buildTextContainer(heading, description, isWide: false),
      ],
    );
  }

  // --- COMMON TEXT BOX ---
  Widget _buildTextContainer(String heading, String description, {required bool isWide}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 40 : 20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(243, 245, 247, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically in Row
        children: [
          Text(
            heading,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: isWide ? 28 : 20,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: isWide ? 16 : 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
          const ShopNowLink(),
        ],
      ),
    );
  }
}
