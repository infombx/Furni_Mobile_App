import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/Items/counter.dart';
import 'package:furni_mobile_app/product/data/orders.dart';


class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.item,
    required this.onPriceChanged,
    required this.onQuantityChanged,
    required this.initialQuantity,
  });

  final MyOrders item;
  final void Function(double) onPriceChanged;
  final void Function(int) onQuantityChanged;
  final int initialQuantity;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  late int selectedQty;

  @override
  void initState() {
    super.initState();
    selectedQty = widget.initialQuantity >= 1 ? widget.initialQuantity : 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onQuantityChanged(selectedQty);
      widget.onPriceChanged(widget.item.price * selectedQty);
    });
  }

  void _onQuantityChanged(int value) {
    setState(() => selectedQty = value);
    widget.item.quantity = value;
    widget.onQuantityChanged(value);
    widget.onPriceChanged(widget.item.price * value);
  }

void removeOrders() {
  setState(() {

    ordersList.remove(widget.item);
  });

  widget.onPriceChanged(0);
  widget.onQuantityChanged(0);
}
  ImageProvider resolveImage(String image) {
  if (image.startsWith('http')) {
    return NetworkImage(image);
  }
  return AssetImage(image);
}

 @override
Widget build(BuildContext context) {
  final itemPrice = widget.item.price * selectedQty;

  return SizedBox(
    height: 150, // Reduced height to fit content better
    width: double.infinity,
    child: Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5), // Increased padding for better spacing
        child: Row(
          children: [
            // 1. IMAGE SECTION
            Container(
              width: 80, // Increased from 50 for better visibility
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: resolveImage(widget.item.image),
                  fit: BoxFit.cover, // Cover looks better for product thumbs
                  onError: (_, __) {}, 
                ),
              ),
            ),

            const SizedBox(width: 12), // Consistent spacing

            // 2. TEXT & COUNTER SECTION (The Fix)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.measurement,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF666E72),
                    ),
                  ),
                  const SizedBox(height: 10),
                  QuantityCounter(
                    max: widget.item.stock,
                    initialQuantity: selectedQty,
                    onQuantityChanged: _onQuantityChanged,
                  ),
                ],
              ),
            ),

            // 3. PRICE & DELETE SECTION
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: removeOrders,
                  ),
                  Text(
                    '\$${itemPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
