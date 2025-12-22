import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:furni_mobile_app/home_page/toggle_favorite.dart';
import 'package:furni_mobile_app/product/Product_page.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key, required this.items});
  final List<Product> items;

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 10,
        childAspectRatio: 0.58,
      ),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        
        final item = widget.items[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE CARD (CLICKABLE)
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductPage(
                      product_id: item.id,
                      onQuantityChanged: (value) => qty = value,
                    ),
                  ),
                );
              },
             child: Container(
  height: 200,
  margin: const EdgeInsets.symmetric(horizontal: 8),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    image: DecorationImage(
      // CRITICAL: Use NetworkImage for API URLs
      image: NetworkImage(item.display_image), 
      fit: BoxFit.cover,
      // Error handling for broken links
      onError: (exception, stackTrace) => const Icon(Icons.broken_image),
    ),
  ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Column(
                        children: [
                          _badge('New', Colors.white, Colors.black),
                        
                        ],
                      ),
                    ),

                    /// BUTTON (EXCLUDED FROM TAP)
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 6, 53, 107),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// PRODUCT DETAILS
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingStar(initialRating: item.rating),
                  const SizedBox(height: 4),
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rs ${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _badge(String text, Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
