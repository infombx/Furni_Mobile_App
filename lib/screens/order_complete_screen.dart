import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/dummy items/data_required.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/dummy items/myItems.dart';
import 'package:intl/intl.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';
import 'package:furni_mobile_app/product/product_page.dart';

class OrderCompleteScreen extends StatefulWidget {
  const OrderCompleteScreen({
    super.key,
    required this.item,
    required this.Total,
    required this.quantity,
    required this.paymode,
  });

  final List<CartItem> item;
  final double Total;
  final Map<int, int> quantity;
  final String paymode;

  @override
  State<OrderCompleteScreen> createState() => _OrderCompleteScreenState();
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  ImageProvider imageProviderFor(String url) {
    if (url.startsWith('http')) {
      return NetworkImage(url);
    } else {
      final assetPath = url.startsWith('assets/') ? url : 'assets/images/$url';
      return AssetImage(assetPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child: Header(
            onProductTap: (productId) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(
                    product_id: productId,
                    onQuantityChanged: (qty) {},
                  ),
                ),
              );
            },
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 11,
                  color: Colors.black54,
                ),
                label: const Text(
                  'back to home',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          Text(
            'Complete!',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        '3',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Order Complete',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: Colors.black, endIndent: 70, thickness: 2),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Thank you!',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6C7275),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      'assets/images/Celebration.png',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Your order',
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'has been',
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'received',
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 20,
                    children: [
                      for (var x in dummycart)
                        Stack(
                          children: [
                            Container(
                              height: 110,
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProviderFor(x.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.black,
                                child: Text(
                                  '${widget.quantity[x.id] ?? 0}',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                Text(
                  'Order code:',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                const Text('345678_23456'),
                const Divider(),
                Text(
                  'Date:',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                Text(formattedDate),
                const Divider(),
                Text(
                  'Total:',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                Text('${widget.Total}'),
                const Divider(),
                Text(
                  'Payment method:',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                Text(widget.paymode),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
