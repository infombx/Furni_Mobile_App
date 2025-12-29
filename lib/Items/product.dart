import 'package:flutter/material.dart';
import 'package:furni_mobile_app/dummy items/data_required.dart';
import 'package:furni_mobile_app/Items/counter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.item,
    required this.onPriceChanged,
    required this.onQuantityChanged,
    required this.initialQuantity,
  });

  final CartItem item;
  final void Function(double itemprice) onPriceChanged;
  final void Function(int quantity) onQuantityChanged;
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
    final initialPrice = widget.item.price * selectedQty;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onQuantityChanged(selectedQty);
      widget.onPriceChanged(initialPrice);
    });
  }

  void _onQuantityChanged(int value) {
    setState(() {
      selectedQty = value;
      widget.item.quantity = value;
    });
    widget.onQuantityChanged(selectedQty);
    widget.onPriceChanged(widget.item.price * selectedQty);
  }

  @override
  Widget build(BuildContext context) {
    final double itemPrice = (widget.item.price * selectedQty);
    ImageProvider imageProvider;
    final url = widget.item.imageUrl;

    if (url.isNotEmpty && url.startsWith('http')) {
      imageProvider = NetworkImage(url);
    } else {
      final assetPath = url.startsWith('assets/') ? url : 'assets/images/$url';
      imageProvider = AssetImage(assetPath);
    }

    return SizedBox(
      height: 190,
      width: double.infinity,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      widget.item.productName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item.property,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: const Color.fromARGB(255, 102, 110, 114),
                      ),
                    ),
                    const SizedBox(height: 12),
                    QuantityCounter(
                      initialQuantity: widget.item.quantity,
                      onQuantityChanged: (value) {
                        _onQuantityChanged(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${itemPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
