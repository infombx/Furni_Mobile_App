import 'package:flutter/material.dart';
import 'package:teakworld/Items/cart_listview.dart';
import 'package:teakworld/models/user_model.dart';
import 'package:teakworld/screens/order_summary_screen.dart';
import 'package:teakworld/services/OrdersService.dart';
import 'package:teakworld/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/product/data/orders.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  AppUser? currentUser;
  bool isLoading = true;
  

  List<MyOrders> get userCart {
    if (currentUser == null) return [];
    return ordersList.where((order) => order.userId == currentUser!.id).toList();
  }

  double currentSubtotal = 0.0;
  String shippingType = 'F';
  Map<int, int> itemQuantities = {};

  // Calculation logic
  double get shippingCost {
    switch (shippingType) {
      case 'E': return 15.0;
      case 'P': return 21.0;
      default: return 0.0;
    }
  }

  double get total => currentSubtotal + shippingCost;
Future<void> _load() async {
  await CartPersistence.loadCart();
  final user = await AuthService().fetchMe();
  
  if (mounted) {
    setState(() {
      currentUser = user;
      // Clear and rebuild map to ensure it matches the freshly loaded list
      itemQuantities.clear(); 
      for (final item in userCart) {
        itemQuantities[item.product_id] = item.quantity;
      }
    });
  }
}

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < userCart.length; i++) {
      itemQuantities[i] = userCart[i].quantity;
    }
      _load();
  }

Future<void> _navigateToCheckout() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => OrderSummaryScreen(
        subtotal: currentSubtotal,
        Total: total,
        shipping: shippingCost,
        quantities: Map<int, int>.from(itemQuantities), 
      ),
    ),
  );


  if (result != null && result is Map<String, dynamic>) {
    setState(() {
      if (result.containsKey('quantities')) {
        itemQuantities = Map<int, int>.from(result['quantities']);
      }
      if (result.containsKey('subtotal')) {
        currentSubtotal = result['subtotal'];
      }
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildStepIndicator(),
              const Divider(color: Colors.black, thickness: 2),
              const SizedBox(height: 20),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Cart Items List
                      SizedBox(
                        height: 350,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListedItems(
                                onSubtotalChanged: (subtotal) {
                                  setState(() => currentSubtotal = subtotal);
                                },
                                onQuantityChanged: (quantities) {
                                  setState(() {
                                    itemQuantities = Map<int, int>.from(quantities);
                                  });
                                },
                                initialQuantities: itemQuantities,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      _buildCartSummaryCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, size: 14, color: Colors.black),
            label: const Text('back', style: TextStyle(color: Colors.black)),
          ),
        ),
        Text(
          'Cart',
          style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _stepCircle('1', Colors.black),
            const SizedBox(width: 12),
            Text('Shopping cart', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ],
        ),
        _stepCircle('2', const Color(0xFFB1B5C3)),
      ],
    );
  }

  Widget _stepCircle(String text, Color color) {
    return Container(
      height: 35, width: 35,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildCartSummaryCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cart Summary', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          _shippingTile('F', 'Free Shipping', 0.00),
          const SizedBox(height: 10),
          _shippingTile('E', 'Express Shipping', 15.00),
          const SizedBox(height: 10),
          _shippingTile('P', 'Pick Up', 21.00),
          const SizedBox(height: 25),
          _row('Subtotal', currentSubtotal),
          const Divider(height: 30),
          _row('Total', total, big: true),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _navigateToCheckout,
              child: const Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shippingTile(String value, String label, double price) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: shippingType == value ? Colors.black : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        activeColor: Colors.black,
        value: value,
        groupValue: shippingType,
        onChanged: (val) => setState(() => shippingType = val!),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: GoogleFonts.inter(fontSize: 14)),
            Text('\$${price.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, double value, {bool big = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: big ? 18 : 14, fontWeight: big ? FontWeight.bold : FontWeight.w500)),
        Text('\$${value.toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: big ? 18 : 14, fontWeight: big ? FontWeight.bold : FontWeight.w500)),
      ],
    );
  }
}
