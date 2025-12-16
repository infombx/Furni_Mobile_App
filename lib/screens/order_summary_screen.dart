import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/Items/Shipping_address.dart';
import 'package:furni_mobile_app/Items/cart_listview.dart';
import 'package:furni_mobile_app/Items/contact_details.dart';
import 'package:furni_mobile_app/dummy%20items/myItems.dart';
import 'package:furni_mobile_app/screens/order_complete_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSummaryScreen extends StatefulWidget {
  OrderSummaryScreen({
    super.key,
    required this.subtotal,
    required this.Total,
    required this.shipping,
    required this.quantities,
  });
  double subtotal = 0;
  double Total = 0;
  double shipping = 0;
  final Map<int, int> quantities;

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  double itemprice = 0;
  Map<int, int> itemQuantities = {};
  double get total => itemprice + widget.shipping;

  void _popWithResult() {
    Navigator.of(context).pop(<String, dynamic>{
      'quantities': itemQuantities,
      'subtotal': itemprice,
    });
  }

  String modePay = 'Credit Card';

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Header()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _popWithResult();
                        },
                        label: Text(
                          'back',
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
                    'Check Out',
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
                                '2',
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
                            'Checkout details',
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
                          color: Color(0xFFB1B5C3),
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
                    ],
                  ),
                  Divider(color: Colors.black, endIndent: 70, thickness: 2),
                  const SizedBox(height: 30),
                  ContactDetailsForm(),
                  const SizedBox(height: 30),
                  ShippingDetailsForm(),
                  const SizedBox(height: 30),
                  Container(
                    height: 500,

                    width: 450,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              'Payment Method',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: RadioListTile(
                                  activeColor: Colors.black,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Pay by Card Credit',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: 'Credit Card',
                                  groupValue: modePay,
                                  onChanged: (value) => setState(() {
                                    modePay = value!;
                                  }),
                                  visualDensity: const VisualDensity(
                                    horizontal: -4.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: RadioListTile(
                                  activeColor: Colors.black,
                                  title: Row(
                                    children: [
                                      Text(
                                        'Paypal',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: 'PayPal',
                                  groupValue: modePay,
                                  onChanged: (value) => setState(() {
                                    modePay = value!;
                                  }),
                                  visualDensity: const VisualDensity(
                                    horizontal: -4.0,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            Divider(
                              color: Colors.black,
                              endIndent: 0,
                              thickness: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'CARD NUMBER',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 50,
                                  width: 416,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: '1234 1234 1234',
                                      hintStyle: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      'EXPIRATION DATE',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 50,
                                      width: 160,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey),
                                        color: Colors.white,
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'MM/YY',
                                          hintStyle: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      'CVC',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 50,
                                      width: 160,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey),
                                        color: Colors.white,
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'CVC code',
                                          hintStyle: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                          border: InputBorder.none,
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
                    ),
                  ),

                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 450,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order Summary',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 400,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListedItems(
                                          initialQuantities: widget.quantities,
                                          onSubtotalChanged: (subtotal) {
                                            setState(() {
                                              itemprice = subtotal;
                                            });
                                          },
                                          onQuantityChanged: (quantities) =>
                                              setState(() {
                                                itemQuantities =
                                                    Map<int, int>.from(
                                                      quantities,
                                                    );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                      'Shipping',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${widget.shipping}',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 1, color: Colors.black12),
                                Row(
                                  children: [
                                    Text(
                                      'Subtotal',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '$itemprice',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                Divider(thickness: 1, color: Colors.black12),
                                Row(
                                  children: [
                                    Text(
                                      'Total',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '$total',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 450,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => OrderCompleteScreen(
                                  item: dummycart,
                                  Total: total,
                                  paymode: modePay,
                                  quantity: itemQuantities,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Place Order',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
        Container(
          width: 450,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed:(){Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx)=> OrderCompleteScreen(
                item:dummycart,
                Total: total,
                paymode: modePay,
                quantity: itemQuantities,
                  )));},
               child: Text('Place Order',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600, 
                  fontSize: 16, color: Colors.white
          ),
          ),
          ),
        )
          ]
          ),
        ),
        
    );
  }
}
