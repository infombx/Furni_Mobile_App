import 'package:flutter/material.dart';
import 'package:teakworld/product/widget/rating_star.dart';

class FeaturedArticle extends StatelessWidget {
  const FeaturedArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Apply border radius
            child: Image.asset(
              'assets/images/bedroom.png',
              width: 150, // Adjust width to take full available width
              height: 210, // Set fixed height for the image
              fit: BoxFit.cover, // Image will cover the area
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(padding: const EdgeInsets.only(left: 10), child: RatingStar()),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Buffet Table',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make text bold
              fontSize: 18, // Adjust font size if needed
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            '\$250',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make text bold
              fontSize: 16, // Adjust font size if needed
              color: const Color.fromARGB(
                255,
                0,
                0,
                0,
              ), // Optional: Make the price color green
            ),
          ),
        ),
      ],
    );
  }
}
