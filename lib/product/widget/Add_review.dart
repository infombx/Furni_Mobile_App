import 'package:flutter/material.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/product/data/reviewdata.dart';
import 'package:furni_mobile_app/services/profile_service.dart';

import 'package:furni_mobile_app/models/user_model.dart';
import 'package:furni_mobile_app/services/update_profilepicture.dart';
import 'package:furni_mobile_app/widgets/account%20details.dart';
import 'package:furni_mobile_app/widgets/address_details.dart';
import 'package:furni_mobile_app/widgets/footer/profile_picture.dart';
import 'package:furni_mobile_app/widgets/user_profile.dart';
import 'package:furni_mobile_app/services/auth_service.dart';
import 'package:furni_mobile_app/services/api_review.dart';

class AddReview extends StatefulWidget {
  const AddReview({super.key, required this.productId});
  final String productId;

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  @override
  Widget build(BuildContext context) {
    String selectedValue = 'Account';
    AppUser? currentUser;
    bool isLoading = true;

    final AuthService authService = AuthService();
    Future<void> loadUser() async {
      final user = await authService.fetchMe();
      setState(() {
        currentUser = user;
        isLoading = false;
      });
    }

    @override
    void initState() {
      super.initState();
      loadUser();
    }

    final TextEditingController comment = TextEditingController();
    int selectedRating = 0;
    void handlePost() async {
      if (comment.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please enter a comment")));
        return;
      }

      // Assuming currentUser is loaded from your _loadUser()
      if (currentUser == null) return;

      try {
        await ReviewService().postReview(
          name: currentUser!.displayName,
          comment: comment.text,
          rating: selectedRating,
          productIds: [widget.productId],
        );

        comment.clear();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Review submitted!")));

        // Optional: Refresh the list or go back
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error submitting review: $e")));
      }
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                RatingStar(
                  onRatingSelected: (value) {
                    setState(() {
                      value = selectedRating;
                    });
                  },
                ),
                SizedBox(width: 10),
                Text('11 reviews'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tray Table',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),

          Container(
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 224, 224, 224),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: comment,
                      decoration: InputDecoration(
                        hintText: 'Share your thoughts',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: -5,
                    child: IconButton(
                      onPressed: () {
                        handlePost();
                      },
                      icon: Icon(
                        Icons.arrow_circle_right,
                        color: const Color.fromARGB(255, 37, 37, 37),
                        size: 39,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
