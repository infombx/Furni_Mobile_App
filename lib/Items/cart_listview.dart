import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Items/product.dart';
import 'package:furni_mobile_app/dummy items/myItems.dart';

class ListedItems extends StatefulWidget{
  const ListedItems({super.key, required this.onSubtotalChanged, required this.onQuantityChanged, required this.initialQuantities});
  
  final void Function(double subtotal) onSubtotalChanged;
  final void Function(Map <int, int> quantities) onQuantityChanged;
    final Map<int,int>? initialQuantities;
  @override
  State<ListedItems> createState() => _ListedItems();
}
class _ListedItems extends State<ListedItems> {
   final Map<int, int> quantities = {};

  double computeSubtotal() {
    double sum = 0.0;
    for (int i = 0; i < dummycart.length; i++) {
      final qty = quantities[i] ?? 1; // default qty 1
      sum += dummycart[i].price * qty;
    }
    return sum;
  }

  void _onQuantityChanged(int index, int qty) {
    setState(() {
      quantities[index] = qty;
    });
       
    widget.onSubtotalChanged(computeSubtotal());
     widget.onQuantityChanged.call(Map<int,int>.from(quantities));
  }
  
  
  @override
    void initState() {
    super.initState();
    if (widget.initialQuantities != null) {
      quantities.addAll(widget.initialQuantities!);
    }
    // ensure defaults for every item
    for (int i = 0; i < dummycart.length; i++) {
      quantities.putIfAbsent(i, () => 1);
    }

    // notify parent about initial subtotal & quantities (optional but useful)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSubtotalChanged(computeSubtotal());
      widget.onQuantityChanged(Map<int,int>.from(quantities));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        dummycart.length,
        (index) => ProductWidget(
          item: dummycart[index],
          // optional onPriceChanged not needed now
          onPriceChanged: (_) {},
          // wire quantity change with index
          onQuantityChanged: (qty) => _onQuantityChanged(index, qty),
          initialQuantity: quantities[index] ?? 1,
        ),
      ),
    );
  }
}
