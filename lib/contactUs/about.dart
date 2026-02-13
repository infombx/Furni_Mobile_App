import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/services/contactus_services.dart';

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
          // Centered loader for better UX
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
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

        // Responsive calculation using LayoutBuilder
        return LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final bool isTablet = width > 600;

            return ConstrainedBox(
              // Prevents text lines from being too long on desktop (readability)
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (headingBlock != null)
                    Text(
                      headingBlock['heading'],
                      softWrap: true,
                      style: TextStyle(
                        // Scale font: 27 on mobile, 40 on large screens
                        fontSize: isTablet ? 20 : 17,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.8,
                        height: 1.2,
                      ),
                    ),

                  SizedBox(height: isTablet ? 20 : 15),

                  if (textBlock != null)
                    Text(
                      extractText(textBlock['content']),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        // Body text: 16 on mobile, 18 on tablet/desktop
                        fontSize: isTablet ? 15 : 12,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        height: 1.6, // Increased line height for better legibility
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
