import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Items/cart_listview.dart';
import 'package:furni_mobile_app/screens/order_summary_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/dummy items/myItems.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double currentSubtotal = 0.0;
  String shippingType = 'F';
  Map<int, int> itemQuantities = {};

  double get shippingCost {
    switch (shippingType) {
      case 'E':
        return 15.0;
      case 'P':
        return 21.0;
      default:
        return 0.0;
    }
  }

  double get total => currentSubtotal + shippingCost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context, {
                      'subtotal': currentSubtotal,
                      'quantities': itemQuantities,
                    });
                  },

                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 11,
                    color: Colors.black54,
                  ),
                  label: const Text(
                    'back',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                'Cart',
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // header step row
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
                          '1',
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
                      'Shopping cart',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    color: const Color(0xFFB1B5C3),
                  ),
                  child: Center(
                    child: Text(
                      '2',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.black, endIndent: 70, thickness: 2),
            const SizedBox(height: 30),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 350,
                      child: SingleChildScrollView(
                        child: ListedItems(
                          onSubtotalChanged: (subtotal) {
                            setState(() => currentSubtotal = subtotal);
                          },
                          onQuantityChanged: (quantities) {
                            setState(() {
                              itemQuantities = Map<int, int>.from(quantities);
                            });
                          },
                          initialQuantities: {
                            for (int i = 0; i < dummycart.length; i++)
                              i: dummycart[i].quantity,
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cart Summary',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),

                          _shippingTile('F', 'Free Shipping', 0),
                          const SizedBox(height: 12),
                          _shippingTile('E', 'Express Shipping', 15),
                          const SizedBox(height: 12),
                          _shippingTile('P', 'Pick Up', 21),

                          const SizedBox(height: 30),
                          _row('Subtotal', currentSubtotal),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          _row('Total', total, big: true),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OrderSummaryScreen(
                                      subtotal: currentSubtotal,
                                      Total: total,
                                      shipping: shippingCost,
                                      quantities: Map<int, int>.from(
                                        itemQuantities,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'CheckOut',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
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
      ),
    );
  }

  Widget _shippingTile(String value, String label, double price) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: RadioListTile<String>(
        activeColor: Colors.black,
        value: value,
        groupValue: shippingType,
        onChanged: (val) => setState(() => shippingType = val!),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            Text(
              price.toStringAsFixed(2),
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        visualDensity: const VisualDensity(horizontal: -4),
      ),
    );
  }

  Widget _row(String label, double value, {bool big = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: big ? 16 : 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value.toStringAsFixed(2),
          style: GoogleFonts.inter(
            fontSize: big ? 16 : 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
