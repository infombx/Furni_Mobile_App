import 'package:flutter/material.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/services/api_review.dart';
import 'package:furni_mobile_app/services/auth_service.dart';
import 'package:furni_mobile_app/models/user_model.dart';

class AddReview extends StatefulWidget {
  const AddReview({super.key, required this.productId, this.onReviewPosted});
  final String productId;
  final VoidCallback? onReviewPosted;

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final ReviewService _reviewService = ReviewService();
  final AuthService _authService = AuthService();
  final TextEditingController _commentController = TextEditingController();
  
  AppUser? _currentUser;
  int _selectedRating = 0;
  int _reviewCount = 0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final user = await _authService.fetchMe();
    if (mounted) {
      setState(() => _currentUser = user);
      _fetchReviewCount();
    }
  }

  Future<void> _fetchReviewCount() async {
    try {
      final reviews = await _reviewService.fetchReviewWebs(productId: widget.productId);
      if (mounted) setState(() => _reviewCount = reviews.length);
    } catch (e) {
      debugPrint("Count error: $e");
    }
  }

  void _handlePost() async {
    if (_commentController.text.trim().isEmpty) {
      _showSnack("Please enter a comment");
      return;
    }
    if (_selectedRating == 0) {
      _showSnack("Please select a rating");
      return;
    }
    if (_currentUser == null) {
      _showSnack("Please log in first");
      return;
    }

    setState(() => _isSubmitting = true);
    FocusScope.of(context).unfocus(); // Close keyboard

    try {
      // Ensure productId is a valid integer
      int? pId = int.tryParse(widget.productId);
      if (pId == null) throw "Invalid Product ID";

      await _reviewService.postReview(
        name: _currentUser!.displayName,
        comment: _commentController.text.trim(),
        rating: _selectedRating,
        productId: pId,
        pfpId: _currentUser!.profileImageId,
      );

      if (mounted) {
        _showSnack("Review submitted successfully!");
        _commentController.clear();
        setState(() {
          _selectedRating = 0;
          _isSubmitting = false;
        });
        if (widget.onReviewPosted != null) widget.onReviewPosted!();
        _fetchReviewCount();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        _showSnack("Error: $e");
        debugPrint("SUBMIT_ERROR: $e");
      }
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Customer Reviews', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            RatingStar(
              initialRating: _selectedRating,
              onRatingSelected: (val) => setState(() => _selectedRating = val),
            ),
            const SizedBox(width: 10),
            Text('$_reviewCount reviews'),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(hintText: 'Share your thoughts', border: InputBorder.none),
                ),
              ),
              _isSubmitting 
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : IconButton(
                    icon: const Icon(Icons.arrow_circle_right, size: 36, color: Colors.black87),
                    onPressed: _handlePost,
                  ),
            ],
          ),
        ),
      ],
    );
  }
}