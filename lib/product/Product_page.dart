import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/dummy%20items/myItems.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';
import 'package:furni_mobile_app/product/widget/Add_review.dart';
import 'package:furni_mobile_app/product/widget/details_card.dart';
import 'package:furni_mobile_app/product/widget/display_images.dart';
import 'package:furni_mobile_app/product/widget/navigation.dart';
import 'package:furni_mobile_app/product/widget/review.dart';
import 'package:furni_mobile_app/services/api_dummydata.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.onQuantityChanged, required this.product_id});
  final void Function(int) onQuantityChanged;
  final int product_id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: ApiService.fetchProducts(),
      builder: (context, snapshot) {
        // 1. Handle Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // 2. Handle Error State
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(body: Center(child: Text("Error: ${snapshot.error ?? 'No data found'}")));
        }

        // 3. Find the specific product safely
        final productList = snapshot.data!;
        final product = productList.firstWhere((p) => p.id == product_id);
        print("DEBUG: Image URL is: ${product.images}");

        return Scaffold(
          appBar: AppBar(title: const Header()),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Navigation(),
                  const SizedBox(height: 16),
                  // Ensure DisplayImages can handle the list provided
                  SizedBox(
                    height: 414, 
                    width: 311, 
                    child: DisplayImages(images: product.images),
                  ),
                  const SizedBox(height: 16),
                  DetailsCard(
                    name: product.name,
                    category: product.category,
                    colours: product.colours,
                    description: product.description,
                    measurements: product.measurements,
                    price: product.price,
                    rating: product.rating,
                    quantity: product.quantity,
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1.5),
                  const SizedBox(height: 15),
                        AddReview(productId:product_id.toString()),
                  const SizedBox(height: 20),
                  const Review(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const SizedBox(height: 90, child: GlassFloatingNavBar()),
        );
      },
    );
  }
}