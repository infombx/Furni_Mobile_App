import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/home_page/data/hero_banner_section.dart';
import 'package:furni_mobile_app/services/api_herobanner.dart';

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
          return const Center(child: CircularProgressIndicator());
        } 
        else if (snapshot.hasError) {
          return Container(
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(16)),
            child: const Center(child: Text("Connection Error: Check IP or Internet")),
          );
        } 
        else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
            child: const Center(child: Text("No banners found in Strapi")),
          );
        }

        final banners = snapshot.data!;

        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
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
                                fit: BoxFit.cover, // Ensures image fills the container
                                errorBuilder: (ctx, err, stack) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image, size: 50),
                                ),
                              ),
                              // Gradient for text readability
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.black38, Colors.transparent, Colors.black54],
                                  ),
                                ),
                              ),
                              // CONTENT WITH OVERFLOW FIX
                              Positioned(
                                top: 20,
                                left: 10,
                                right: 10, // Forces text to wrap instead of overflowing
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      banner.headline,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      banner.subtext,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white.withOpacity(0.9), 
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: double.infinity,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          showIndicator: false,
                          onPageChanged: (index, reason) {
                            setState(() => _currentIndex = index);
                          },
                        ),
                      ),
                      
                      // Custom Indicators
                      Positioned(
                        bottom: 15,
                        child: Row(
                          children: List.generate(banners.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentIndex == index ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(_currentIndex == index ? 1 : 0.5),
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
            ),
          ],
        );
      },
    );
  }
}