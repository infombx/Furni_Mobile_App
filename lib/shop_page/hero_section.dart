import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        
        // Define Breakpoints
        final bool isDesktop = width > 1024;
        final bool isTablet = width > 600 && width <= 1024;

        // --- RESPONSIVE VALUES ---
        // Increase height for larger screens
        double sectionHeight = 250; 
        if (isDesktop) sectionHeight = 550;
        else if (isTablet) sectionHeight = 450;

        // Adjust font sizes
        double titleSize = isDesktop ? 56 : (isTablet ? 42 : 25);
        double subTitleSize = isDesktop ? 20 : 14;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : 20, 
            vertical: 20
          ),
          child: Stack(
            children: [
              // Background Container
              Container(
                width: double.infinity,
                height: sectionHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), // Smoother corners
                  image: const DecorationImage(
                    image: AssetImage('assets/images/shop_hero_section.png'),
                    fit: BoxFit.cover,
                    // Center the image so the focal point stays visible
                    alignment: Alignment.center, 
                  ),
                ),
              ),

              // Gradient Overlay (Optional but recommended for text readability)
              Container(
                height: sectionHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Positioned Content
              Positioned.fill(
                child: Align(
                  alignment: isDesktop ? Alignment.centerLeft : Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 60 : 20
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: isDesktop 
                          ? CrossAxisAlignment.start 
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Shop Now',
                          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                          style: GoogleFonts.poppins( // Using Poppins for a modern look
                            color: const Color(0xFF141718),
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: isDesktop ? 400 : double.infinity,
                          child: Text(
                            'Let’s design the place you always imagined.',
                            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontSize: subTitleSize,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
