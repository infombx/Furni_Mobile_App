import 'package:flutter/material.dart';
import 'package:furni_mobile_app/product/Product_page.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/services/auth_service.dart';
import 'package:furni_mobile_app/product/data/orders.dart';
import 'package:furni_mobile_app/services/OrdersService.dart';

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
        stock: item.quantity
      ),
    );

    await CartPersistence.saveCart();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      // CRITICAL FIXES FOR SHOPPAGE VISIBILITY:
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(), 
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
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
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
                      left: 10,
                      right: 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 6, 53, 107),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => handleAddToCart(context, item),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rs ${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
}