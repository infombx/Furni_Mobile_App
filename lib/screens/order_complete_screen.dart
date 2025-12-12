import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/dummy items/data_required.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/dummy items/myItems.dart';
import 'package:intl/intl.dart';

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
  State<OrderCompleteScreen> createState() {
    return _OrderCompleteScreenState();
  }
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  double currentSubtotal = 0.0;
  Map<int, int> itemQuantities = {};
  @override
  Widget build(context) {
    ImageProvider imageProviderFor(String url) {
      if (url.startsWith('http')) {
        return NetworkImage(url);
      } else {
        final assetPath = url.startsWith('assets/')
            ? url
            : 'assets/images/$url';
        return AssetImage(assetPath);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Header()),
      body: ListView(
        padding: const EdgeInsets.all(15.0),

        children: [
          Column(
            children: [
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    label: Text(
                      'back to home',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 11,
                      color: Colors.black54,
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
              Divider(color: Colors.black, endIndent: 70, thickness: 2),

              Container(
                decoration: BoxDecoration(color: Colors.white),

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
                            color: Color(0xFF6C7275),
                          ),
                        ),
                        SizedBox(width: 5),
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
                    Row(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            alignment: WrapAlignment.start,

                            spacing: 20,
                            runSpacing: 8,
                            children: [
                              for (var x in dummycart)
                                Stack(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 110,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProviderFor(
                                                x.imageUrl,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 65,
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 8,
                                            child: Text(
                                              '${widget.quantity[x.id] ?? 0}',
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Order code:',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF6C7275),
                      ),
                    ),
                    Text(
                      '345678_23456',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(thickness: 1, color: Colors.black12),
                    const SizedBox(height: 10),
                    Text(
                      'Date:',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF6C7275),
                      ),
                    ),
                    Text(
                      '$formattedDate ',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(thickness: 1, color: Colors.black12),
                    const SizedBox(height: 10),
                    Text(
                      'Total:',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF6C7275),
                      ),
                    ),
                    Text(
                      '${widget.Total}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(thickness: 1, color: Colors.black12),
                    const SizedBox(height: 10),
                    Text(
                      'Payment method:',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF6C7275),
                      ),
                    ),
                    Text(
                      widget.paymode,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(thickness: 1, color: Colors.black12),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
