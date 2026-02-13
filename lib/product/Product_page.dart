import 'package:flutter/material.dart';
import 'package:teakworld/Header/header.dart';
import 'package:teakworld/navbar/navbar.dart';
import 'package:teakworld/product/data/dummyData.dart';
import 'package:teakworld/product/widget/Add_review.dart';
import 'package:teakworld/product/widget/details_card.dart';
import 'package:teakworld/product/widget/display_images.dart';
import 'package:teakworld/product/widget/navigation.dart';
import 'package:teakworld/product/widget/review.dart';
import 'package:teakworld/services/api_dummydata.dart';

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
        final product = productList.firstWhere(
          (p) => p.id == widget.product_id,
          orElse: () => productList.first,
        );

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(1, 100, 109, 1),
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Center( // Centers the header content on large screens
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Header(
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
            ),
          ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              // Threshold for Tablet/Desktop
              bool isWideScreen = constraints.maxWidth > 700;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Navigation(),
                          const SizedBox(height: 24),
                          
                          if (isWideScreen)
                            // --- TABLET / DESKTOP LAYOUT ---
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5, // Image takes up slightly more space
                                  child: DisplayImages(display_image: product.images),
                                ),
                                const SizedBox(width: 25),
                                Expanded(
                                  flex: 4,
                                  child: _buildDetailsCard(product),
                                ),
                              ],
                            )
                          else
                            // --- MOBILE LAYOUT ---
                            Column(
                              children: [
                                DisplayImages(display_image: product.images),
                                const SizedBox(height: 24),
                                _buildDetailsCard(product),
                              ],
                            ),

                          const SizedBox(height: 25),
                          const Divider(thickness: 1.5),
                          const SizedBox(height: 30),
                          
                          // Reviews section usually stays full width but can be constrained
                          // AddReview(
                          //   productId: widget.product_id.toString(),
                          //   onReviewPosted: () => setState(() {}),
                          // ),
                          // const SizedBox(height: 20),
                          // Review(productId: widget.product_id.toString()),
                          const SizedBox(height: 120), // Bottom nav space
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const GlassFloatingNavBar(currentIndex: 1),
        ],
      ),
        
        );
      },
    );
  }

  // Helper method to keep build clean
  Widget _buildDetailsCard(Product product) {
    return DetailsCard(
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
    );
  }
}
