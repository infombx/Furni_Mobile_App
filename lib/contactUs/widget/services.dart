import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/services/api_serviceCard.dart';
import 'package:teakworld/contactUs/data/servicesData.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  static const String baseUrl = "http://159.65.15.249:1337";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ServiceCard>>(
      future: ApiService.fetchServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final services = snapshot.data!;

        // Use LayoutBuilder to get the available width
        return LayoutBuilder(
          builder: (context, constraints) {
            // Logic to determine column count based on width
            int crossAxisCount = 2;
            if (constraints.maxWidth > 900) {
              crossAxisCount = 4; // Large screens
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 4; // Tablets
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16), // Added some padding for the grid
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  // We increase the ratio slightly if the screen is wider to prevent tall cards
                  childAspectRatio: constraints.maxWidth > 600 ? 1.0 : 0.85,
                ),
                itemBuilder: (context, index) {
                  final card = services[index];

                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(243, 245, 247, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.network(
                          '$baseUrl${card.iconUrl}',
                          width: constraints.maxWidth > 600 ? 56 : 48,
                          placeholderBuilder: (context) => const SizedBox(
                            width: 48,
                            height: 48,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          card.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: constraints.maxWidth > 600 ? 16 : 14,
                            fontFamily: GoogleFonts.inter().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          card.subTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: constraints.maxWidth > 600 ? 14 : 12,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            color: const Color.fromRGBO(108, 114, 117, 1),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
