import 'package:flutter/material.dart';
import 'package:furni_mobile_app/data/data_cons.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.items});

  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        // image logic MUST be here
        ImageProvider imageProvider;
        final url = item.image;
        if (url.startsWith('http')) {
          imageProvider = NetworkImage(url);
        } else {
          imageProvider = AssetImage(
            url.startsWith('assets/') ? url : 'assets/images/$url',
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ),
                    ),

                    Positioned(
                      top: 12,
                      left: 12,
                      child: Column(
                        children: [
                          _tag('New', Colors.white, Colors.black),
                          const SizedBox(height: 6),
                          _tag('-50%', Colors.green, Colors.white),
                        ],
                      ),
                    ),

                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),
            const RatingStar(),
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

            Text(
              '\$${item.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _tag(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }
}
