import 'package:flutter/material.dart';
import 'package:furni_mobile_app/dummy items/myItems.dart';
import 'package:google_fonts/google_fonts.dart';


class CartSummary extends StatefulWidget{
  const CartSummary({super.key,});
  
  @override
  State<CartSummary> createState (){
    return _CartSummaryState();
  }
}
class _CartSummaryState extends State<CartSummary>{
  int selectedQty = 1;
  String shippingType = 'F';

  double get subtotal {
    
    return dummycart.fold(0.0, (double prev, item) => item.price + prev);
  }

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

  double get total => subtotal + shippingCost;

  @override
  Widget build (context){
 
   return Container(
    height: 540,
    width:380 ,
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
           Text(subtotal.toStringAsFixed(2),style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700,))
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
      (width: 350,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(child: TextButton( 
          onPressed: (){}, child: Text('CheckOut', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)))))
       ],),
     ),
   );
  }
}