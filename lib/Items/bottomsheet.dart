import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/Items/cart_listview.dart';
import 'package:furni_mobile_app/dummy%20items/myItems.dart';
import 'package:furni_mobile_app/screens/order_summary_screen.dart';
import 'package:furni_mobile_app/screens/cart_screen.dart';

class BottomCartSheet extends StatefulWidget {
  const BottomCartSheet({super.key});

  @override
  State<BottomCartSheet> createState() => _BottomCartSheetState();
}

class _BottomCartSheetState extends State<BottomCartSheet> {
  double itemprice = 1;
  double currentSubtotal = 0.0;
  String shippingType = 'F';
  Map<int, int> itemQuantities = {};

  double get shippingCost {
    switch (shippingType) {
      case 'E': // Express
        return 15.0;
      case 'P': // Pick Up
        return 21.0;
      case 'F': // Free
      default:
        return 0.0;
    }
  }

  double get total => currentSubtotal + shippingCost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      height: MediaQuery.of(context).size.height * 0.80,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
                Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 350,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListedItems(
                                  onSubtotalChanged: (subtotal) {
                                    setState(() {
                                      currentSubtotal = subtotal;
                                    });
                                  },
                                  onQuantityChanged: (quantities) {
                                    setState(() {
                                      itemQuantities =
                                          Map<int, int>.from(quantities);
                                    });
                                  },
                                  initialQuantities: {
                                    for (int i = 0; i < dummycart.length; i++)
                                      i: dummycart[i].quantity,
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal', style: GoogleFonts.inter(fontSize: 16)),
                            Text(
                              currentSubtotal.toStringAsFixed(2),
                              style: GoogleFonts.inter(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: GoogleFonts.poppins(fontSize: 20)),
                            Text(
                              total.toStringAsFixed(2),
                              style: GoogleFonts.poppins(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => OrderSummaryScreen(
                                    subtotal: currentSubtotal,
                                    Total: total,
                                    shipping: shippingCost,
                                    quantities:
                                        Map<int, int>.from(itemQuantities),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'CheckOut',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final result =
                                await Navigator.push<Map<String, dynamic>>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CartScreen(),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                currentSubtotal =
                                    result['subtotal'] as double;
                                itemQuantities = Map<int, int>.from(
                                    result['quantities'] as Map);
                              });
                            }
                          },
                          child: const Text(
                            'View Cart',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
