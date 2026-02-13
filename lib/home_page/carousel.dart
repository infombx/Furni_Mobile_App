import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/home_page/data/hero_banner_section.dart';
import 'package:teakworld/services/api_herobanner.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;
  static const String baseUrl = "http://159.65.15.249:1337";
  Future<List<HeroBannerSection>>? _heroBannersFuture;

  @override
  void initState() {
    super.initState();
    _heroBannersFuture = ApiService.fetchHeroBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HeroBannerSection>>(
      future: _heroBannersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 450, // Match mobile height for loader
            child: Center(child: CircularProgressIndicator(color: Colors.black)),
          );
        } else if (snapshot.hasError) {
          return _buildErrorState("Connection Error");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildErrorState("No banners found");
        }

        final banners = snapshot.data!;

        return LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final bool isTablet = width > 600;
            final bool isDesktop = width > 1024;

            // --- INCREASED HEIGHTS ---
            double carouselHeight = 450; // Mobile
            if (isDesktop) {
              carouselHeight = 950; // Desktop
            } else if (isTablet) {
              carouselHeight = 600; // Tablet
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 25 : 14,
                vertical: 14,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  height: carouselHeight,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      FlutterCarousel(
                        items: banners.map((banner) {
                          final String imagePath = banner.image;
                          final String fullImageUrl = imagePath.startsWith('http')
                              ? imagePath
                              : '$baseUrl${imagePath.startsWith('/') ? '' : '/'}$imagePath';

                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                fullImageUrl,
                                fit: BoxFit.cover, // Image fills the tall container
                                errorBuilder: (ctx, err, stack) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image, size: 50),
                                ),
                              ),
                              // Enhanced Gradient for taller height
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0.0, 0.4, 1.0],
                                    colors: [
                                      Colors.black.withOpacity(0.4),
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                              // Content
                              Positioned(
                                top: isDesktop ? 30 : 20, 
                                left: isDesktop ? 50 : 30,
                                right: isDesktop ? 50 : 30,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      banner.headline,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: isDesktop ? 25 : (isTablet ? 20 : 16),
                                        fontWeight: FontWeight.bold,
                                        height: 1.1,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      banner.subtext,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: isDesktop ? 16 : 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: carouselHeight,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          showIndicator: false,
                          onPageChanged: (index, reason) {
                            setState(() => _currentIndex = index);
                          },
                        ),
                      ),
                      
                      // Custom Indicators
                      Positioned(
                        bottom: 20,
                        child: Row(
                          children: List.generate(banners.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              width: _currentIndex == index ? 20 : 12,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _currentIndex == index 
                                    ? Colors.white 
                                    : Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[100], 
        borderRadius: BorderRadius.circular(16)
      ),
      child: Center(child: Text(message, style: const TextStyle(color: Colors.grey))),
    );
  }
}
