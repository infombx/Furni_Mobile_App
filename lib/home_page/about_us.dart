import 'package:flutter/material.dart';
import 'package:furni_mobile_app/contactUs/contactus.dart';
import 'package:furni_mobile_app/services/api_aboutus.dart';
import 'package:furni_mobile_app/home_page/data/aboutUs.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  static const String baseUrl = "http://159.65.15.249:1337";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AboutData?>(
      future: ApiService.fetchAboutSection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink(); // Hide if data fails to load
        }

        final data = snapshot.data!;

        return Column(
          children: [
            // Image from Strapi
            if (data.imageUrl.isNotEmpty)
              Image.network(
                '$baseUrl${data.imageUrl}',
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            
            const SizedBox(height: 16),
            
            Text(
              data.heading,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 8),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                data.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            // Underlined Action Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const Contactus()),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: Text(
                              data.ctaText,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward, size: 16, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}