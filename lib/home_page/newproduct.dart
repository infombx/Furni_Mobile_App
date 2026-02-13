import 'package:flutter/material.dart';
import 'package:teakworld/home_page/widget.dart';
import 'package:teakworld/product/data/dummyData.dart';
import 'package:teakworld/shop/shopPage.dart';
import 'package:teakworld/home_page/newproduct.dart';
import 'package:teakworld/services/api_dummydata.dart';
import 'package:google_fonts/google_fonts.dart';

class NewArrival extends StatefulWidget {
  const NewArrival({super.key});

  @override
  State<NewArrival> createState() => _NewArrivalState();
}

class _NewArrivalState extends State<NewArrival> {
  late PageController _controller;
  double _currentPage = 0;
  int _totalProducts = 0;
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService.fetchProducts();
    // Initialize with a tighter default fraction
    _controller = PageController(viewportFraction: 0.92);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    // Define breakpoints
    final bool isLaptop = screenWidth > 1024;
    final bool isTablet = screenWidth > 600 && screenWidth <= 1024;

    // --- TIGHTER SPACING LOGIC ---
    // Higher number = Card takes more width = Less space between cards
    double dynamicFraction;
    if (isLaptop) {
      dynamicFraction = 0.25; // Shows 3 cards very close together
    } else if (isTablet) {
      dynamicFraction = 0.35; // Exactly 2 cards side-by-side
    } else {
      dynamicFraction = 0.75; // Mobile: 92% width, only 4% gap on each side
    }

    // Update controller if the screen is resized
    if (_controller.viewportFraction != dynamicFraction) {
      _controller = PageController(
        viewportFraction: dynamicFraction,
        initialPage: _currentPage.round(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------- Header ----------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isLaptop ? 40 : 18),
          child: Text(
            'New Arrivals',
            style: GoogleFonts.poppins(
              fontSize: isLaptop ? 42 : (isTablet ? 36 : 28),
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: const Color(0xFF141718),
            ),
          ),
        ),

        const SizedBox(height: 25),

        // ---------------- Product Slider ----------------
        SizedBox(
          height: isLaptop ? 480 : (isTablet ? 390 : 380),
          child: FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.black));
              }
              if (snapshot.hasError) return Center(child: Text("${snapshot.error}"));

              final products = snapshot.data ?? [];
              if (products.isEmpty) return const Center(child: Text('No products found'));

              if (_totalProducts != products.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _totalProducts = products.length);
                });
              }

              return PageView.builder(
                controller: _controller,
                itemCount: products.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentPage = index.toDouble()),
                itemBuilder: (context, index) {
                  // --- REFINED SCALING ---
                  final diff = (_currentPage - index).abs();
                  // Using 0.05 instead of 0.08 for a subtler, tighter transition
                  // Clamping at 0.95 keeps the cards from shrinking away from each other
                  final scale = (1 - (diff * 0.05)).clamp(0.99, 1.0);
                  
                  return Transform.scale(
                    scale: scale,
                    child: Padding(
                      // Small internal padding for the gutter
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: NewProductCard(item: products[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // ---------------- Modern Scroll Indicator ----------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isLaptop ? 80 : 20, vertical: 10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double handleWidth = _totalProducts > 0
                  ? (constraints.maxWidth / _totalProducts).clamp(60.0, 150.0)
                  : 80.0;

              void handleInteraction(Offset localPosition) {
                if (_totalProducts <= 1) return;
                double percent = localPosition.dx / constraints.maxWidth;
                int targetPage = (percent * _totalProducts).floor().clamp(0, _totalProducts - 1);

                _controller.animateToPage(
                  targetPage,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutQuint,
                );
              }

              return GestureDetector(
                onTapDown: (details) => handleInteraction(details.localPosition),
                onPanUpdate: (details) => handleInteraction(details.localPosition),
                child: Container(
                  height: 20,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutCubic,
                          alignment: Alignment(
                            _totalProducts <= 1
                                ? -1.0
                                : (_currentPage / (_totalProducts - 1) * 2) - 1,
                            0,
                          ),
                          child: Container(
                            width: handleWidth,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: isLaptop ? 40 : 30),
        // ---------------- Footer Link ----------------
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: isLaptop ? 40 : 18),
        //   child: TextButton(
        //     style: TextButton.styleFrom(padding: EdgeInsets.zero),
        //     onPressed: () {
        //       Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Shoppage()));
        //     },
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text(
        //           'More Products',
        //           style: GoogleFonts.poppins(
        //             fontSize: 16,
        //             fontWeight: FontWeight.w600,
        //             color: Colors.black,
        //             decoration: TextDecoration.underline,
        //           ),
        //         ),
        //         const SizedBox(width: 6),
        //         const Icon(Icons.arrow_forward, size: 18, color: Colors.black),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
