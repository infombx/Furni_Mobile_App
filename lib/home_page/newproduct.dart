import 'package:flutter/material.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';
import 'package:furni_mobile_app/shop/shopPage.dart';
// import 'package:furni_mobile_app/services/api_product.dart';
// import 'package:furni_mobile_app/dummy items/testing.dart';
import 'package:furni_mobile_app/home_page/widget.dart';
import 'package:furni_mobile_app/home_page/newproduct.dart';
import 'package:furni_mobile_app/services/api_dummydata.dart';

class NewArrival extends StatefulWidget {
  const NewArrival({super.key});

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  final PageController _controller = PageController(viewportFraction: 0.75);

  double _currentPage = 0;
  int _totalProducts = 0;

  late final Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService.fetchProducts();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18),
          child: Text(
            'New',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Arrivals',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 20),

        // ---------------- Product Slider ----------------
        SizedBox(
          height: 380,
          child: FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              final products = snapshot.data!;
              if (products.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              _totalProducts = products.length;

              return PageView.builder(
                controller: _controller,
                itemCount: products.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index.toDouble();
                  });
                },
                itemBuilder: (context, index) {
                  final scale =
                      (1 - ((_currentPage - index).abs() * 0.1))
                          .clamp(0.9, 1.0);

                  return Transform.scale(
                    scale: scale,
                    child: NewProductCard(
                      item: products[index],
                    ),
                  );
                },
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // ---------------- Indicator Bar ----------------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(50),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _totalProducts == 0
                  ? 0
                  : (_currentPage + 1) / _totalProducts,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // ---------------- More Products ----------------
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const Shoppage()),
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      'More Products',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 16, color: Colors.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}