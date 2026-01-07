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

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.onQuantityChanged,
    required this.product_id,
    this.initialQuantity = 1,
    this.initialColor,
  });

  final void Function(int) onQuantityChanged;
  final int product_id;
  final int initialQuantity;
  final String? initialColor;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: ApiService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(body: Center(child: Text("Error: ${snapshot.error}")));
        }

        final productList = snapshot.data!;
        // Handle case where ID might not exist in the list
        final product = productList.firstWhere(
          (p) => p.id == widget.product_id,
          orElse: () => productList.first, 
        );

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Header(
              onProductTap: (newId) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      product_id: newId,
                      onQuantityChanged: widget.onQuantityChanged,
                    ),
                  ),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
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
                    quantity: widget.initialQuantity,
                    initialColor: widget.initialColor,
                    image: product.display_image,
                    productId: widget.product_id,
                    onQuantityChanged: (qtyMap) {
                      widget.onQuantityChanged(qtyMap[widget.product_id] ?? 1);
                    },
                    stock: product.quantity,
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1.5),
                  const SizedBox(height: 15),
                  AddReview(
                    productId: widget.product_id.toString(),
                    onReviewPosted: () => setState(() {}),
                  ),
                  const SizedBox(height: 20),
                  Review(productId: widget.product_id.toString()),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const SizedBox(
            height: 100, 
            child: GlassFloatingNavBar(currentIndex: 3,)
          ),
        );
      },
    );
  }
}