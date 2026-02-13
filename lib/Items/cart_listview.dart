import 'package:flutter/material.dart';
import 'package:teakworld/Items/product.dart';
import 'package:teakworld/models/user_model.dart';
import 'package:teakworld/product/Product_page.dart';
import 'package:teakworld/product/data/orders.dart';
import 'package:teakworld/services/OrdersService.dart';
import 'package:teakworld/services/auth_service.dart';

class ListedItems extends StatefulWidget {
  const ListedItems({
    super.key,
    required this.onSubtotalChanged,
    required this.onQuantityChanged,
    required this.initialQuantities,
    this.readOnly = false,
  });

  final void Function(double subtotal) onSubtotalChanged;
  final void Function(Map<int, int> quantities) onQuantityChanged;
  final Map<int, int>? initialQuantities;
  final bool readOnly;
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
          
          // Initialize quantities for current user's cart items
          for (int i = 0; i < userCart.length; i++) {
            quantities[i] = userCart[i].quantity;
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
    for (var item in userCart) {
      final qty = quantities[item.product_id] ?? item.quantity;
      sum += (item.price * qty);
    }
    return sum;
  }

  void _onQuantityChanged(int index, int qty) {
    setState(() {
      quantities[index] = qty;
      userCart[index].quantity = qty;
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
        (index) {
          final currentItem = userCart[index];

          return TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ProductPage(
                  product_id: currentItem.product_id,
                  // Use product_id for quantity lookup
                  initialQuantity: quantities[currentItem.product_id] ?? currentItem.quantity,
                  initialColor: currentItem.colorr.isNotEmpty ? currentItem.colorr[0] : null,
                  onQuantityChanged: (value) {
                    _onQuantityChanged(currentItem.product_id, value);
                  },
                ),
              )).then((_) {
                setState(() {}); 
              });
            },
            child: ProductWidget(
            
              item: currentItem,
              onRemove: () async {
                setState(() {
                  // CORRECT: Removes only this specific instance from the global list
                  ordersList.remove(currentItem); 
                });
                
                await CartPersistence.saveCart();

              
                widget.onSubtotalChanged(computeSubtotal());
                widget.onQuantityChanged(Map<int, int>.from(quantities));
              },
              onPriceChanged: (_) {
                widget.onSubtotalChanged(computeSubtotal());
              },
              onQuantityChanged: (qty) {
                _onQuantityChanged(currentItem.product_id, qty);
              },
              initialQuantity: quantities[currentItem.product_id] ?? currentItem.quantity,
            ),
          );
        },
      ),
    );
  }
}
