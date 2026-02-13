import 'package:flutter/material.dart';
import 'package:teakworld/dummy%20items/myItems.dart';
import 'package:teakworld/models/user_model.dart';
import 'package:teakworld/services/auth_service.dart';
import 'package:teakworld/services/profile_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/product/data/orders.dart';

class CartSummary extends StatefulWidget {
  const CartSummary({super.key});

  @override
  State<CartSummary> createState() {
    return _CartSummaryState();
  }
}

class _CartSummaryState extends State<CartSummary> {
  final AuthService _authService = AuthService();

  late Future<AppUser?> _userFuture;

  @override
  void initState() {
    super.initState();
   
    _userFuture = _authService.fetchMe();
  }


  List<MyOrders> userCart(AppUser? user) {
    if (user == null) return [];
    return ordersList.where((order) => order.userId == user.id).toList();
  }

  int selectedQty = 1;
  String shippingType = 'F';


  double subtotal(List<MyOrders> cart) {
    return cart.fold(0.0, (double prev, item) => item.price + prev);
  }

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

  @override
  Widget build(context) {
    return FutureBuilder<AppUser?>(
      future: _userFuture,
      builder: (context, snapshot) {
      
        final AppUser? currentUser = snapshot.data;
        final List<MyOrders> currentCart = userCart(currentUser);
        final double currentSubtotal = subtotal(currentCart);
        final double currentTotal = currentSubtotal + shippingCost;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 540,
            child: Center(child: CircularProgressIndicator(color: Colors.black)),
          );
        }

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: 540,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text('Cart Summary',
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  
            
                  _buildShippingOption(
                      title: 'Free Shipping',
                      cost: '0.00',
                      value: 'F'),
                  const SizedBox(height: 16),

           
                  _buildShippingOption(
                      title: 'Express Shipping',
                      cost: '+15.00',
                      value: 'E'),
                  const SizedBox(height: 16),

       
                  _buildShippingOption(
                      title: 'Pick Up',
                      cost: '21.00',
                      value: 'P'),

                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal',
                          style: GoogleFonts.inter(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                      Text('\$${currentSubtotal.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      Text('\$${currentTotal.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w700))
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: TextButton(
                        onPressed: currentUser == null ? null : () {
              
                        },
                        child: Text(
                          'CheckOut',
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper widget to keep the Radio buttons clean
  Widget _buildShippingOption({required String title, required String cost, required String value}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: RadioListTile<String>(
          activeColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
              Text(cost, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          value: value,
          groupValue: shippingType,
          onChanged: (newValue) => setState(() {
            shippingType = newValue!;
          }),
          visualDensity: const VisualDensity(horizontal: -4.0),
        ),
      ),
    );
  }
}
