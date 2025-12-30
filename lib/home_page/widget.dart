import 'package:flutter/material.dart';
import 'package:furni_mobile_app/product/Product_page.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/home_page/toggle_favorite.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';

class NewProductCard extends StatelessWidget {
  const NewProductCard({
    super.key,
    required this.item,
  });

  final Product item;

  @override
  Widget build(BuildContext context) {
    int qty = 1;
    // Check if there is actually a discount to display the badge
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductPage(
                    onQuantityChanged: (value) => qty = value,
                    product_id: item.id),
              ),
            );
          },
          child: Container(
            width: 260,
            height: 290,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                // Use NetworkImage for the URL from your API
                image: NetworkImage(item.display_image),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) => const Icon(Icons.broken_image),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  left: 16,
                  child: Column(
                    children: [
                      _badge(
                        text: 'New',
                        bg: Colors.white,
                        color: Colors.black,
                      ),
                      // if (hasDiscount) ...[
                      //   const SizedBox(height: 6),
                      //   _badge(
                      //     text: '-${item.percentageDiscount}%',
                      //     bg: Colors.green,
                      //     color: Colors.white,
                      //   ),
                      // ],
                    ],
                  ),
                ),

                /// ADD TO CART
                Positioned(
                  bottom: 13,
                  left: 10,
                  right: 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 6, 53, 107),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Add logic to add item to cart
                    },
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
          padding: const EdgeInsets.only(left: 15, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingStar(initialRating: item.rating),
              const SizedBox(height: 4),
              Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Rs ${item.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _badge({required String text, required Color bg, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
