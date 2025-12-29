import 'package:flutter/material.dart';
import 'package:furni_mobile_app/shop/shopPage.dart';

class ShopNowLink extends StatelessWidget {
  const ShopNowLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => Shoppage()));
          },
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1.2),
                      ),
                    ),
                    child: Text(
                      'Shop now',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward, size: 18, color: Colors.black),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
