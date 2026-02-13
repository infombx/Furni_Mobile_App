import 'package:flutter/material.dart';
import 'package:teakworld/contactUs/contactus.dart';
import 'package:teakworld/home_page/data/aboutUs.dart'; 
import 'package:teakworld/services/api_aboutus.dart'; 

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const String baseUrl = "http://159.65.15.249:1337";

    return FutureBuilder<AboutData?>(
      future: ApiService.fetchAboutSection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator(color: Color(0xFF06356B))),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return const SizedBox.shrink(); 
        }

        final data = snapshot.data!;

        return Column(
          children: [
            // Dynamic Image
            Image.network(
              data.imageUrl.startsWith('http') ? data.imageUrl : '$baseUrl${data.imageUrl}',
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => 
                  Image.asset('assets/images/about_us.png', width: double.infinity),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              data.heading,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 12),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                data.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
              ),
            ),

            const SizedBox(height: 20),

            // CTA Button Section
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const Contactus()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 4), // Space for underline
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.ctaText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 18, color: Colors.black),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }
}
