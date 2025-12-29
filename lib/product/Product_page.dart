import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/product/widget/Add_review.dart';
import 'package:furni_mobile_app/product/widget/details_card.dart';
import 'package:furni_mobile_app/product/widget/display_images.dart';
import 'package:furni_mobile_app/product/widget/navigation.dart';
import 'package:furni_mobile_app/product/widget/review.dart';
import 'package:furni_mobile_app/services/api_dummydata.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
    required this.onQuantityChanged,
    required this.product_id,
  });

  final void Function(int) onQuantityChanged;
  final int product_id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: ApiService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(body: Center(child: Text('No product found')));
        }

        final product = snapshot.data!.firstWhere(
          (p) => p.id == product_id,
          orElse: () => snapshot.data!.first,
        );

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Header(
              onProductTap: (productId) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductPage(
                      product_id: productId,
                      onQuantityChanged: onQuantityChanged,
                    ),
                  ),
                );
              },
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Navigation(),
                const SizedBox(height: 16),

                SizedBox(
                  height: 414,
                  width: 311,
                  child: DisplayImages(display_image: product.images),
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

                /// ✅ Pass product ID correctly
                AddReview(productId: product_id.toString()),

                const SizedBox(height: 20),
                const Review(),
              ],
            ),
          ),

          bottomNavigationBar: const SizedBox(
            height: 90,
            child: GlassFloatingNavBar(),
          ),
        );
      },
    );
  }
}
