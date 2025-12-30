import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/services/api_serviceCard.dart';
import 'package:furni_mobile_app/contactUs/data/servicesData.dart';

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

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: GridView.builder(
            shrinkWrap: true, // Crucial for use inside a SingleChildScrollView
            physics: const NeverScrollableScrollPhysics(), 
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,          // 2 columns
              crossAxisSpacing: 10,       // Horizontal space
              mainAxisSpacing: 10,        // Vertical space
              childAspectRatio: 0.85,     // Adjust height/width ratio
            ),
            itemBuilder: (context, index) {
              final card = services[index];
              
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(243, 245, 247, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Load SVG from Strapi URL
                    SvgPicture.network(
                      '$baseUrl${card.iconUrl}',
                      width: 48,
                      placeholderBuilder: (context) => const SizedBox(
                        width: 48, 
                        height: 48, 
                        child: CircularProgressIndicator(strokeWidth: 2)
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      card.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      card.subTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
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
  }
}