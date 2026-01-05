import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Items/product.dart';
import 'package:furni_mobile_app/models/user_model.dart';
import 'package:furni_mobile_app/product/Product_page.dart';
import 'package:furni_mobile_app/product/data/orders.dart';
import 'package:furni_mobile_app/services/auth_service.dart';

class ListedItems extends StatefulWidget {
  const ListedItems({
    super.key,
    required this.onSubtotalChanged,
    required this.onQuantityChanged,
    required this.initialQuantities,
  });

  final void Function(double subtotal) onSubtotalChanged;
  final void Function(Map<int, int> quantities) onQuantityChanged;
  final Map<int, int>? initialQuantities;

  @override
  State<ListedItems> createState() => _ListedItemsState();
}

class _ListedItemsState extends State<ListedItems> {
  final Map<int, int> quantities = {};
  AppUser? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // 1. Initialize quantities from widget parameters if provided
    if (widget.initialQuantities != null) {
      quantities.addAll(widget.initialQuantities!);
    }
    // 2. Load the user session
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await AuthService().fetchMe();
      if (mounted) {
        setState(() {
          _currentUser = user;
          
  
          for (int i = 0; i < userCart.length; i++) {
            quantities.putIfAbsent(i, () => userCart[i].quantity);
          }
          _isLoading = false;
        });


        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onSubtotalChanged(computeSubtotal());
          widget.onQuantityChanged(Map<int, int>.from(quantities));
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      debugPrint("Error loading user: $e");
    }
  }

  // Filters the global ordersList to only show items belonging to this user
  List<MyOrders> get userCart {
    if (_currentUser == null) return [];
    return ordersList.where((order) => order.userId == _currentUser!.id).toList();
  }

  double computeSubtotal() {
    double sum = 0.0;
    for (int i = 0; i < userCart.length; i++) {
      final qty = quantities[i] ?? 1;
      sum += (userCart[i].price * qty);
    }
    return sum;
  }

  void _onQuantityChanged(int index, int qty) {
    setState(() {
      quantities[index] = qty;
    });

    widget.onSubtotalChanged(computeSubtotal());
    widget.onQuantityChanged(Map<int, int>.from(quantities));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (userCart.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            "Your cart is empty",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: List.generate(
        userCart.length,
        (index) => TextButton(
         onPressed: () {
  final currentItem = userCart[index];
  Navigator.of(context).push(MaterialPageRoute(
    builder: (ctx) => ProductPage(
      product_id: currentItem.product_id,
      // Pass the CURRENT quantity from our local state
      initialQuantity: quantities[index] ?? currentItem.quantity,
      // Pass the CURRENT color from the order object
      initialColor: currentItem.colorr.isNotEmpty ? currentItem.colorr[0] : null,
      onQuantityChanged: (value) {
        // This updates the local 'quantities' map and recalculates subtotal
        _onQuantityChanged(index, value);
      },
    ),
  )).then((_) {
    // This runs when you come BACK from the product page
    setState(() {
      // Refresh the UI to show updated colors/quantities in the list
    });
  });
},
          child: ProductWidget(
            item: userCart[index],
            onPriceChanged: (_) {}, // Handled via computeSubtotal
            onQuantityChanged: (qty) => _onQuantityChanged(index, qty),
            initialQuantity: quantities[index] ?? 1,
          ),
        ),
      ),
    );
  }
}