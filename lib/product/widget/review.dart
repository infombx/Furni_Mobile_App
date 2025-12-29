import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/product/data/reviewdata.dart';
import 'package:furni_mobile_app/services/api_review.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  String selectedValue = "Default";
  // 1. Correctly initialize the service instance
  final ReviewService _reviewService = ReviewService();

  // 2. Store the future in a variable to prevent unnecessary re-fetches on rebuilds
  late Future<List<ReviewWeb>> _reviewsFuture;

  @override
  void initState() {
    super.initState();
    _reviewsFuture = _reviewService.fetchReviewWebs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReviewWeb>>(
      future: _reviewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No reviews yet."));
        }

        List<ReviewWeb> reviews = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${reviews.length} Reviews',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 211, 211, 211),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                underline: SizedBox(),
                icon: Icon(Icons.keyboard_arrow_down),
                menuWidth: double.infinity,
                items: ["Newest", "Oldest", "Default"].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 40),
            Column(
              children: reviews.map((item) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 38,
                            backgroundImage: NetworkImage(item.pictureUrl),
                          ),
                          SizedBox(width: 16),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                ),
                              ),
                              SizedBox(height: 8),
                              RatingStar(
                                initialRating: item.rating,
                                size: 20,
                                readOnly: true,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      Text(
                        item.comment,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: 16),
                      Divider(),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
