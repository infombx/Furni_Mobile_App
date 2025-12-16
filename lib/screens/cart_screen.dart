import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/Items/cart_listview.dart';
import 'package:furni_mobile_app/screens/order_summary_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/dummy%20items/myItems.dart';

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
      case 'F':
      default:
        return 0.0;
    }
  }

  double get total => currentSubtotal + shippingCost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Header()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Back Button
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios, size: 11, color: Colors.black54),
                    label: const Text('Back', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),

              // Title
              Text(
                'Cart',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 30),

              // Shopping cart header
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
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black, endIndent: 70, thickness: 2),
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
                            onQuantityChanged: (quantities) => setState(() {
                              itemQuantities = Map<int, int>.from(quantities);
                            }),
                            initialQuantities: {
                              for (int i = 0; i < dummycart.length; i++)
                                i: dummycart[i].quantity,
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
    height: 540,
    
    decoration: BoxDecoration(
      
      border: Border.all(width: 1, color: Colors.black), borderRadius: BorderRadius.circular(8)
    ),
     child: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const  SizedBox(height: 5,),
        Text('Cart Summary',style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 20,),
           Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black,), borderRadius: BorderRadius.circular(5)
            ),
             child: Padding(
               padding: const EdgeInsets.only(top: 3),
               child: RadioListTile(
             
                activeColor: Colors.black,
                title: Row(
                  
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Free Shipping',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                    Text('0.00', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),)// to be added
                  ],
                ),
                
                value: 'F', 
                groupValue: shippingType,
                onChanged: (value) => setState(() {
                  shippingType = value!;
                }),
                 visualDensity: const VisualDensity(horizontal: -4.0),
                ),
             ),
           ),
          const  SizedBox(height: 16,),
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black), borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: RadioListTile(
              activeColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Express Shipping', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),),
                  Text('+15.00',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600))
                ],
              ),
              value: 'E', 
              groupValue: shippingType,
              onChanged: (value) => setState(() {
                shippingType = value!;
              }),
              visualDensity: const VisualDensity(horizontal: -4.0),
              ),
            ),
          ),
            const SizedBox(height: 16,),
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color:Colors.black ),borderRadius: BorderRadius.circular(5)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: RadioListTile(
              activeColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pick Up',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                  Text('%21.00',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600))
                ],
              ),
              value: 'P',
              groupValue: shippingType,
              onChanged: (value) {
              setState(() {
              shippingType = value!;
                  });
                }, 
                
             visualDensity: const VisualDensity(horizontal: -4.0),
              ),
            ),
          ),
         const SizedBox(height: 30,),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text('Subtotal',style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
           Text(currentSubtotal.toStringAsFixed(2),style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700,))
         ],
       ),
       const   SizedBox(height: 20,),
      Divider(color: Colors.grey,),
       SizedBox(height: 20,),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text('Total',style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
           Text( total.toStringAsFixed(2),style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700))
         ],
       ),
      const  SizedBox(height: 30,),
      Container
      (
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(child: TextButton( 
          // inside CartScreen where you push the OrderSummaryScreen
onPressed: () async {
  final result = await Navigator.of(context).push<Map<String, dynamic>>(
    MaterialPageRoute(
      builder: (ctx) => OrderSummaryScreen(
        subtotal: currentSubtotal,
        Total: total,
        shipping: shippingCost,
        quantities: Map<int,int>.from(itemQuantities),
      ),
    ),
  );

              // Listed items
              SizedBox(
                height: 350,
                child: ListedItems(
                  onSubtotalChanged: (subtotal) {
                    setState(() {
                      currentSubtotal = subtotal;
                    });
                  },
                  onQuantityChanged: (quantities) => setState(() {
                    itemQuantities = Map<int, int>.from(quantities);
                  }),
                  initialQuantities: {
                    for (int i = 0; i < dummycart.length; i++) i: dummycart[i].quantity,
                  },
                ),
              ),
              const SizedBox(height: 30),

              // Cart Summary
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cart Summary', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 20),

                      // Shipping options
                      _buildShippingOption('F', 'Free Shipping', 0.0),
                      const SizedBox(height: 16),
                      _buildShippingOption('E', 'Express Shipping', 15.0),
                      const SizedBox(height: 16),
                      _buildShippingOption('P', 'Pick Up', 21.0),
                      const SizedBox(height: 30),

                      // Subtotal & total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
                          Text(currentSubtotal.toStringAsFixed(2), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                          Text(total.toStringAsFixed(2), style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Checkout button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () async {
                            final result = await Navigator.of(context).push<Map<String, dynamic>>(
                              MaterialPageRoute(
                                builder: (ctx) => OrderSummaryScreen(
                                  subtotal: currentSubtotal,
                                  Total: total,
                                  shipping: shippingCost,
                                  quantities: Map<int,int>.from(itemQuantities),
                                ),
                              ),
                            );

                            if (result != null) {
                              final returnedQuantities = result['quantities'] as Map<int,int>?;
                              final returnedSubtotal = result['subtotal'] as double?;
                              if (returnedQuantities != null) {
                                setState(() {
                                  itemQuantities = Map<int,int>.from(returnedQuantities);
                                });
                              }
                              if (returnedSubtotal != null) {
                                setState(() {
                                  currentSubtotal = returnedSubtotal;
                                });
                              }
                            }
                          },
                          child: Text('CheckOut', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
         
          ],
        ),
        value: value,
        groupValue: shippingType,
        onChanged: (val) => setState(() => shippingType = val!),
        visualDensity: const VisualDensity(horizontal: -4.0),
      ),
    );
  }
}
