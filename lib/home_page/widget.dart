import 'package:flutter/material.dart';
import 'package:furni_mobile_app/data/data_cons.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart'; // ensure correct import
import 'package:furni_mobile_app/home_page/toggle_favorite.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';

class NewProductCard extends StatelessWidget {
  const NewProductCard({super.key, required this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    // Determine image — asset or network
    ImageProvider imageProvider;
    final url = item.image;
    if (url.startsWith('http://') || url.startsWith('https://')) {
      imageProvider = NetworkImage(url);
    } else {
      final assetpath = url.startsWith('assets/') ? url : 'assets/images/$url';
      imageProvider = AssetImage(assetpath);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            MaterialPageRoute(builder: (_) => HomeScreen());
          },
          child: Container(
            width: 260,
            height: 290,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 236, 239, 239),
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                // Example: favorite button on top-right
                Positioned(
                  top: 13,
                  right: 10,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: FavoriteToggleButton(),
                  ),
                ),

                // Example: New and -50% labels at top-left
                Positioned(
                  top: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 248, 246, 246),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'New',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.5),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 4, 206, 31),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            '-50%',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 244, 243, 243),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Example: Add to Cart button at bottom
                Positioned(
                  bottom: 13,
                  left: 10,
                  right: 10,
                  child: Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(const Size(200, 40)),
                        backgroundColor: WidgetStatePropertyAll(
                          const Color.fromARGB(255, 6, 53, 107),
                        ),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Color.fromARGB(255, 246, 245, 245),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RatingStar(),
              const SizedBox(height: 4),
              Text(
                item.name,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                textAlign: TextAlign.left,
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
}
