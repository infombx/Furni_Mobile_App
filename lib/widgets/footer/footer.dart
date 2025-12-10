import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: const Color.fromARGB(231, 20, 18, 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Divider(
              color: const Color.fromARGB(129, 204, 201, 201),
              thickness: 1,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                'Terms of Use',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Copyright © 2025 Furni All rights reserved',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
