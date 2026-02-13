import 'package:flutter/material.dart';
import 'package:teakworld/Items/counter.dart';
import 'package:teakworld/product/widget/select_color.dart';
import 'package:teakworld/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/product/data/orders.dart';
import 'package:teakworld/services/OrdersService.dart';

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
    colorselected = widget.initialColor ?? 
        (widget.colours.isNotEmpty ? widget.colours[0] : "Default");
  }

  void handleAddToCart(BuildContext context) async {
    final authService = AuthService();
    final user = await authService.fetchMe();
    
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to add items to cart')),
      );
      return;
    }

    // Add to local orders list
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
        stock: widget.stock,
      ),
    );

    widget.onQuantityChanged({widget.productId: selectedqty});
    await CartPersistence.saveCart();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.name} added to cart!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final bool isTablet = maxWidth > 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Product Name ---
            Text(
              widget.name,
              style: TextStyle(
                fontSize: isTablet ? 38 : 28,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.8,
                fontFamily: GoogleFonts.poppins().fontFamily,
                height: 1.1,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 3),

            // --- Description ---
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(255, 108, 109, 117),
                letterSpacing: 0,
                fontFamily: GoogleFonts.inter().fontFamily,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 3),

            // --- Price ---
            Text(
              'Rs ${widget.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.poppins().fontFamily,
                letterSpacing: -0.6,
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Divider(
                color: Color.fromARGB(255, 230, 230, 230),
                thickness: 1,
              ),
            ),

            // --- Measurements ---
            Text(
              'Measurements',
              style: TextStyle(
                fontSize: 14,
                color: const Color.fromARGB(255, 108, 109, 117),
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.inter().fontFamily,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.measurements,
              style: TextStyle(
                fontSize: 18,
                fontFamily: GoogleFonts.inter().fontFamily,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 7),

            // --- Color Selection ---
            Row(
              children: [
                Text(
                  'Choose Color ',
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 108, 109, 117),
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 10, color: Color.fromARGB(255, 108, 109, 117))
              ],
            ),
            const SizedBox(height: 7),
            SelectColor(
              colorsNames: widget.colours,
              initialColor: colorselected,
              onColorChanged: (value) => setState(() => colorselected = value),
            ),
            
            const SizedBox(height: 25),

            // --- Action Row (Counter + Button) ---
            // This Row will stay side-by-side even on the smallest screens
            Row(
              children: [
                // Fixed-width counter
                QuantityCounter(
                  initialQuantity: selectedqty,
                  onQuantityChanged: (v) => setState(() => selectedqty = v),
                ),
                
                const SizedBox(width: 12),

                // Flexible button filling remaining space
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => handleAddToCart(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 52), // High touch-target height
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown, // Shrinks text if button gets too tiny
                      child: Text(
                        'Add to cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
