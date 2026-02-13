import 'package:flutter/material.dart';
import 'package:teakworld/product/Product_page.dart';
import 'package:teakworld/product/data/dummyData.dart';
import 'package:teakworld/services/auth_service.dart';
import 'package:teakworld/product/data/orders.dart';
import 'package:teakworld/services/OrdersService.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key, required this.items});
  final List<Product> items;

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  int qty = 1;

  @override
  void initState() {
    super.initState();
    CartPersistence.loadCart();
  }

  void handleAddToCart(BuildContext context, Product item) async {
    final authService = AuthService();
    final user = await authService.fetchMe();

    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to add items to cart')),
      );
      return;
    }

    ordersList.add(
      MyOrders(
          product_id: item.id,
          image: item.display_image,
          quantity: qty,
          description: item.description,
          price: item.price,
          colorr: item.colours,
          name: item.name,
          userId: user.id,
          measurement: item.measurements,
          stock: item.quantity),
    );

    await CartPersistence.saveCart();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // --- RESPONSIVE LOGIC ---
        final double width = constraints.maxWidth;
        int crossAxisCount;
        double aspectRatio;

        if (width > 1200) {
          crossAxisCount = 6; // Desktop
          aspectRatio = 0.65;
        } else if (width > 800) {
          crossAxisCount = 4; // Tablet Large
          aspectRatio = 0.62;
        } else if (width > 600) {
          crossAxisCount = 3; // Tablet Small
          aspectRatio = 0.60;
        } else {
          crossAxisCount = 2; // Mobile
          aspectRatio = 0.58;
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12, // Increased spacing for better clarity
            mainAxisSpacing: 16,
            childAspectRatio: aspectRatio,
          ),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded( // Added Expanded so the image area scales with aspect ratio
                  child: InkWell(
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                        image: DecorationImage(
                          image: NetworkImage(item.display_image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 8,
                            right: 8,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 6, 53, 107),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => handleAddToCart(context, item),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white, fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rs ${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
