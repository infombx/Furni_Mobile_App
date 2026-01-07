import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/product/data/reviewdata.dart';
import 'package:furni_mobile_app/services/api_review.dart';

class Review extends StatefulWidget {
  const Review({super.key, required this.productId});
  final String productId;

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final ReviewService _reviewService = ReviewService();
  late Future<List<ReviewWeb>> _reviewFuture;

  @override
  void initState() {
    super.initState();
    // CALLING HERE ensures the request happens once and doesn't reset 
    // when the UI rebuilds in the APK.
    _reviewFuture = _reviewService.fetchReviewWebs(productId: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReviewWeb>>(
      future: _reviewFuture,
      builder: (context, snapshot) {
        // 1. LOADING STATE
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. ERROR STATE (Crucial for debugging the APK)
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    "Error: ${snapshot.error}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _reviewFuture = _reviewService.fetchReviewWebs(productId: widget.productId);
                      });
                    },
                    child: const Text("Retry Connection"),
                  )
                ],
              ),
            ),
          );
        }

        // 3. EMPTY STATE
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: Text("No reviews yet.")),
          );
        }

        // 4. DATA SUCCESS STATE
        final reviews = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            thickness: 1,
            indent: 70,
            endIndent: 16,
            color: Colors.grey[200],
          ),
          itemBuilder: (context, index) {
            final r = reviews[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  backgroundImage: NetworkImage(r.pictureUrl),
                  onBackgroundImageError: (_, __) => const Icon(Icons.person),
                ),
                title: Text(
                  r.name,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    RatingStar(initialRating: r.rating, readOnly: true),
                    const SizedBox(height: 6),
                    Text(
                      r.comment,
                      style: GoogleFonts.inter(
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}