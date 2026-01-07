import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';
import 'package:furni_mobile_app/product/data/orders.dart';

class OrderCompleteScreen extends StatefulWidget {
  const OrderCompleteScreen({
    super.key,
    required this.item,
    required this.Total,
    required this.quantity,
    required this.paymode,
  });

  final List<MyOrders> item;
  final double Total;
  final Map<int, int> quantity;
  final String paymode;

  @override
  State<OrderCompleteScreen> createState() => _OrderCompleteScreenState();
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  ImageProvider _getImageProvider(String url) {
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
        title: const Header(),
        automaticallyImplyLeading: false,
      ),
      body: widget.item.isEmpty 
        ? const Center(child: Text("No items found in order."))
        : ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
            
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  label: const Text('back to home', style: TextStyle(color: Colors.black)),
                  icon: const Icon(Icons.arrow_back_ios, size: 14, color: Colors.black),
                ),
              ),

              const SizedBox(height: 10),
              Text(
                'Complete!',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 40),
              ),
              
              const SizedBox(height: 30),

              // Step Indicator
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 20,
                    child: Text('3', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Order Complete',
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Divider(color: Colors.black, thickness: 2, height: 40),

              // Thank You Section
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
                  const SizedBox(width: 8),
                  const Icon(Icons.celebration, color: Colors.orange, size: 20),
                ],
              ),
              
              const SizedBox(height: 20),
              Text(
                'Your order has been received',
                style: GoogleFonts.poppins(fontSize: 34, fontWeight: FontWeight.w500, height: 1.2),
              ),

              const SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.item.asMap().entries.map((entry) {
    int index = entry.key;
    var x = entry.value;
    
    // If the map was saved by index instead of product_id:
    final qty = widget.quantity[index] ?? 1;
                    
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 110,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                              image: DecorationImage(
                                image: _getImageProvider(x.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -5,
                            right: -5,
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 12,
                              child: Text(
                                '$qty',
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 30),

              // Order Details Summary
              _buildDetailRow('Order code:', 'ORD-${DateTime.now().millisecondsSinceEpoch}'),
              _buildDetailRow('Date:', formattedDate),
              _buildDetailRow('Total:', '\$${widget.Total.toStringAsFixed(2)}'),
              _buildDetailRow('Payment method:', widget.paymode, isLast: true),
            ],
          ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isLast = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: const Color(0xFF6C7275))),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black)),
        const SizedBox(height: 10),
        if (!isLast) const Divider(thickness: 1, color: Colors.black12),
        if (!isLast) const SizedBox(height: 10),
      ],
    );
  }
}