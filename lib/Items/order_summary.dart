import 'package:flutter/material.dart';
import 'package:teakworld/Items/cart_listview.dart';
import 'package:teakworld/dummy%20items/myItems.dart';
import 'package:teakworld/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/product/data/orders.dart';
class OrderSummary extends StatefulWidget{
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  AppUser? currentUser;
  bool isLoading = true;
  List<MyOrders> get userCart {
    if (currentUser == null) return [];
    return ordersList.where((order) => order.userId == currentUser!.id).toList();
  }
  double itemprice = 0;
  Map<int,int> itemQuantities = {};
  @override
  Widget build (context){
    return Column(
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
                  Text('Order Summary', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),),
                  const SizedBox(height: 20,),
                     SizedBox(
                      height: 400,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                           ListedItems(
  onSubtotalChanged: (subtotal) {
    setState(() {
      itemprice = subtotal;
    });
  },
  onQuantityChanged: (quantities) {
    setState(() {
      itemQuantities = Map<int,int>.from(quantities);
    });
  },

  // ✅ Correct: Pass a MAP of all initial quantities
  initialQuantities: {
    for (int i = 0; i < userCart.length; i++) i : userCart[i].quantity
  },
),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      
                      children: [
                        Text('Shipping', style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16),),
                         const Spacer(),
                        Text('shippingType',style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),)
                      ],
                    ),
                  Divider(thickness: 1, color: Colors.black12,),
                  Row(
                    
                      children: [
                        Text('Subtotal', style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16),),
                         const Spacer(),
                        Text('99.00',style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16)),
                        Divider(thickness: 1, color: Colors.black12,),
                      ],
                    ), 
                    Divider(thickness: 1, color: Colors.black12,),
                     Row(
                      
                    
                      children: [
                        Text('Total', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),),
                        const Spacer(),
                        Text('99.00',style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20)),
                        Divider(thickness: 1, color: Colors.black12,),
                      ],
                    ), 
                ],
              ),
            ),
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
          child: TextButton(onPressed:(){}, child: Text('Place Order', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white
          ),
          ),
          ),
        )
      ],
    );
  }
}
