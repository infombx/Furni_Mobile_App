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
    });
    widget.onQuantityChanged(selectedQty);
    widget.onPriceChanged(widget.item.price * selectedQty);
  }

  @override
  Widget build(BuildContext context) {
    double itemPrice = (widget.item.price * selectedQty);
    ImageProvider imageProvider;
    final url = widget.item.imageUrl;
   

    if (url.startsWith('http')) {
      imageProvider = NetworkImage(url);
    } else {
      final assetPath = url.startsWith('assets/') ? url : 'assets/images/$url';
      imageProvider = AssetImage(assetPath);
    }
    return SizedBox(
      height: 190,
      width: 410,
      child: Card(
        child: Row(
          children: [
            Container(
              height: 150,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider, // to be added
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    widget.item.productName,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  // to be added
                  Text(
                    widget.item.property,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color.fromARGB(255, 102, 110, 114),
                    ),
                  ), // to be added
                  SizedBox(height: 12),
                  QuantityCounter(
                    initialQuantity: widget.item.quantity, // <-- Now it works
                    onQuantityChanged: (value) {
                      setState(() {
                        selectedQty = value;
                        widget.item.quantity = value; // <-- Update the model
                      });

                      widget.onQuantityChanged(value);
                      widget.onPriceChanged(widget.item.price * value);
                    },
                    max: 9,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    widget.item.productName,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
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
                      setState(() {
                        selectedQty = value;
                        widget.item.quantity = value;
                      });
                      widget.onQuantityChanged(value);
                      widget.onPriceChanged(widget.item.price * value);
                    },
                    max: 9,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        TextSpan(
                          text: '$itemPrice',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
