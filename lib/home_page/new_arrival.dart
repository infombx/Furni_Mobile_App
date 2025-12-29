import 'package:flutter/material.dart';
import 'package:furni_mobile_app/data/data_cons.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/data/dummy_data.dart';

// Rename this to a proper name instead of `Widget`
class DummyNewProductCard extends StatelessWidget {
  const DummyNewProductCard({super.key, required this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    // your card build logic here...
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 260,
          height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 236, 239, 239),
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(item.image),
              fit: BoxFit.cover,
            ),
          ),
          // ... overlay, buttons, etc ...
        ),
        const SizedBox(height: 8),
        const RatingStar(),
        const SizedBox(height: 4),
        Text(
          item.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 2),
        Text(
          '\$${item.price.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class NewArrival extends StatelessWidget {
  const NewArrival({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        const SizedBox(height: 16),
        SizedBox(
          height: 380,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: dummyData.map((item) {
                return DummyNewProductCard(item: item);
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 13),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              Text(
                'More Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}
