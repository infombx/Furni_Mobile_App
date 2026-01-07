import 'package:flutter/material.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';
import 'package:furni_mobile_app/shop/shopPage.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                settings: const RouteSettings(name: '/home'),
                builder: (_) => const HomeScreen(),
              ),
              (route) => false,
            );
          },
          child: Text(
            'Home',
            style: TextStyle(
              color: const Color.fromARGB(255, 96, 95, 95),
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(width: 4),
        Icon(
          Icons.keyboard_arrow_right_outlined,
          size: 14,
          color: const Color.fromARGB(255, 95, 95, 95),
        ),
        SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => const Shoppage()));
          },
          child: Text(
            'Shop',
            style: TextStyle(
              color: const Color.fromARGB(255, 96, 95, 95),
              fontSize: 14,
            ),
          ),
        ),

        SizedBox(width: 4),
        Icon(
          Icons.keyboard_arrow_right_outlined,
          size: 14,
          color: const Color.fromARGB(255, 95, 95, 95),
        ),
        SizedBox(width: 4),

        Text(
          'Product',
          style: TextStyle(
            color: const Color.fromARGB(255, 18, 18, 18),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
