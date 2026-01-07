import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String text;
  final String iconUrl;

  const InfoCard({
    super.key,
    required this.title,
    required this.text,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SvgPicture.network(iconUrl, height: 32, width: 32),
          const SizedBox(height: 16),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: const Color.fromARGB(255, 108, 114, 117),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
