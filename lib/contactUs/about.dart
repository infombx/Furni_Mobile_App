import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/services/contactus_services.dart';

class About extends StatelessWidget {
  const About({super.key});

  String extractText(List content) {
    return content
        .map((p) => (p['children'] as List).map((c) => c['text'] ?? '').join())
        .join('\n\n');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: ContactPageService.fetchBlocks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final blocks = snapshot.data ?? [];

        final headingBlock = blocks.firstWhere(
          (b) => b['__component'] == 'blocks.heading',
          orElse: () => null,
        );

        final textBlock = blocks.firstWhere(
          (b) => b['__component'] == 'blocks.text',
          orElse: () => null,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (headingBlock != null)
              Text(
                headingBlock['heading'],
                softWrap: true,
                maxLines: null,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 27,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.6,
                ),
              ),

            const SizedBox(height: 20),

            if (textBlock != null)
              Text(
                textAlign: TextAlign.justify,
                extractText(textBlock['content']),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        );
      },
    );
  }
}
