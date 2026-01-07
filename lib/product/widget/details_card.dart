import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Items/counter.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';
import 'package:furni_mobile_app/product/widget/select_color.dart';
import 'package:furni_mobile_app/services/OrdersService.dart';
import 'package:furni_mobile_app/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/product/data/orders.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({
    super.key,
    required this.productId,
    required this.image,
    required this.name,
    required this.category,
    required this.colours,
    required this.description,
    required this.measurements,
    required this.price,
    required this.rating,
    required this.quantity,
    this.initialColor,
    required this.onQuantityChanged,
    required this.stock,
  });

  final int productId;
  final String image;
  final String name;
  final String category;
  final String description;
  final double price;
  final String measurements;
  final List<String> colours;
  final int quantity;
  final int rating;
  final String? initialColor;
  final void Function(Map<int, int>) onQuantityChanged;
  final int stock;

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  late int selectedqty;
  late String colorselected;

  @override
  void initState() {
    super.initState();
    selectedqty = widget.quantity;
    colorselected =
        widget.initialColor ?? (widget.colours.isNotEmpty ? widget.colours[0] : "Default");
  }

 void handleAddToCart(BuildContext context) async {
    final authService = AuthService();
    final user = await authService.fetchMe();
    if (user == null) return;


      else {
        ordersList.add(
          MyOrders(
            product_id: widget.productId,
            image: widget.image,
            quantity: selectedqty,
            description: widget.description,
            price: widget.price,
            colorr: [colorselected],
            name: widget.name,
            userId: user.id,
            measurement: widget.measurements,
            stock: widget.stock
          ),
        );
      }
   widget.onQuantityChanged({widget.productId: selectedqty});
  await CartPersistence.saveCart();
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('${widget.name} added to cart!')));
    }


  

  

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingStar(initialRating: widget.rating),
        Text(widget.name, style: GoogleFonts.poppins(fontSize: 32)),
        Text(widget.description),
        Text('Rs ${widget.price}'),

        SelectColor(
          colorsNames: widget.colours,
          initialColor: colorselected,
          onColorChanged: (value) => setState(() => colorselected = value),
        ),

        Row(
          children: [
            QuantityCounter(
              max: widget.stock,
              initialQuantity: selectedqty,
              onQuantityChanged: (v) => setState(() => selectedqty = v),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => handleAddToCart(context),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(w * 0.55, 45),
                backgroundColor: Colors.black,
              ),
              child: const Text('Add to cart', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ],
    );
  }

}