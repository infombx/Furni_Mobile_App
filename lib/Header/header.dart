import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // --- HEADER ----
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(icon: const Icon(Icons.menu), onPressed: () {}),

                // Middle (logo)
                SvgPicture.asset(
                  'assets/images/furniLogo.svg', // (fix extension too, explained next)
                  alignment: Alignment.centerRight,
                  width: 70,
                ),
                const Spacer(),
                // Right side
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart_checkout,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.person_outline_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
