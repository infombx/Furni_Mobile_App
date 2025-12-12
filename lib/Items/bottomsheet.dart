import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/Items/cart_listview.dart';
import 'package:furni_mobile_app/dummy items/data_required.dart';
import 'package:furni_mobile_app/dummy%20items/myItems.dart';
import 'package:furni_mobile_app/screens/order_summary_screen.dart';

class BottomCartSheet extends StatefulWidget {
  const BottomCartSheet({super.key});

  @override
  State<BottomCartSheet> createState() => _BottomCartSheetState();
}

class _BottomCartSheetState extends State<BottomCartSheet> {
  double itemprice = 1;
  double currentSubtotal = 0.0; 
  String shippingType = 'F';
  Map<int,int> itemQuantities = {};
  double get shippingCost {
    switch (shippingType) {
      case 'E': // Express
        return 15.0;
      case 'P': // Pick Up (you had "%21.00" — using 21.0 here)
        return 21.0;
      case 'F': // Free
      default:
        return 0.0;
    }
  }
  double get total => currentSubtotal + shippingCost;

  @override
  Widget build(BuildContext context) {
    
    return 
       FractionallySizedBox(
        
         child: FractionallySizedBox(
          heightFactor: 1,
           child: SingleChildScrollView(
             child: BottomSheet(
              
              onClosing: () {Navigator.of(context).pop();},
               builder: (ctx) {
              return Container(
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                      Text('Cart', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 40),),
                  const SizedBox(height: 30,),
                   SizedBox(
                  height: 350,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListedItems(onSubtotalChanged: (subtotal) {
                                setState(() {
                                  currentSubtotal = subtotal;
                                });
                              },onQuantityChanged: (quantities) => setState(() {
                                itemQuantities = Map<int,int>.from(quantities);
                              
                              }),  initialQuantities: {
                      for (int i = 0; i < dummycart.length; i++) i : dummycart[i].quantity}
                  
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 35,),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Text('Subtotal',style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400)),
           Text(currentSubtotal.toStringAsFixed(2),style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600,))
                   ],),
                   Divider(thickness: 1,color: Colors.black12,),
                   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text('Total',style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500)),
           Text( total.toStringAsFixed(2),style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500))
         ],),
         Container
      (width: 350,
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

  // if result is returned, update local state
  if (result != null) {
    // result expected to contain 'quantities' (Map<int,int>) and 'subtotal' (double)
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

           child: Text('CheckOut', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white))))),
           TextButton(onPressed: (){}, child: Text('View Cart', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600,decoration: TextDecoration.underline, decorationColor: Colors.black),))
       ],),
     );
  }),

                   

                  ),
                ),
              );
                   }
          
  }
