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
      ordersList.removeWhere(
        (item) => item.product_id == widget.item.product_id,
      );
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
      height: 190,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: resolveImage(widget.item.image),
                    fit: BoxFit.fitWidth,
                    onError: (_, __) {}, // 🔥 critical for Web
                  ),
                ),
              ),

              const Spacer(),

              Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    widget.item.name,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.item.measurement,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF666E72),
                    ),
                  ),
                  const SizedBox(height: 12),
                  QuantityCounter(
                    initialQuantity: selectedQty,
                    onQuantityChanged: _onQuantityChanged,
                  ),
                ],
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${itemPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: removeOrders,
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
