import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furni_mobile_app/product/product_page.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Header extends StatefulWidget {
  final Function(int productId)? onProductTap;

  const Header({super.key, this.onProductTap});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _showSearch = false;
  bool _isLoading = false;
  bool _hasSearched = false;

  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  List<Map<String, dynamic>> _results = [];
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    _removeOverlay();
    super.dispose();
  }

  void _toggle(bool value) {
    setState(() {
      _showSearch = value;
      if (!value) {
        _hasSearched = false;
        _results = [];
        _controller.clear();
        _removeOverlay();
      } else {
        _showOverlay();
      }
    });
  }

  void _onChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search(query);
    });
  }

  Future<void> _search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      setState(() {
        _results = [];
        _hasSearched = false;
      });
      _updateOverlay();
      return;
    }

    setState(() => _isLoading = true);
    _updateOverlay();

    try {
      // populate=* is critical to get the featuredImage object
      final url = 'http://159.65.15.249:1337/api/products?filters[title][\$containsi]=$trimmed&populate=*';
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        final List data = body['data'] ?? [];

        final results = data.map<Map<String, dynamic>>((e) {
          final String? imagePath = e['featuredImage']?['url'];
          return {
            'id': e['id'],
            'name': e['title'] ?? 'Unknown',
            'price': e['price']?.toString() ?? '0.00',
            'image_url': imagePath != null ? 'http://159.65.15.249:1337$imagePath' : null,
          };
        }).toList();

        setState(() {
          _results = results;
          _hasSearched = true;
        });
      }
    } catch (e) {
      debugPrint("Search error: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
      _updateOverlay();
    }
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = OverlayEntry(builder: (context) => _buildOverlay());
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _updateOverlay() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

Widget _buildOverlay() {

  final double headerHeight = MediaQuery.of(context).padding.top + 80;



  return Positioned(

    top: headerHeight,

    left: 0,

    right: 0,

    bottom: 0,

    child: Material( // <--- ADD THIS MATERIAL WIDGET

      color: const Color.fromARGB(255, 255, 255, 255), // Keeps the underlying container's color

      child: Container(

        decoration: BoxDecoration(

          color: Colors.white,

          boxShadow: [

            BoxShadow(

              color: Colors.black.withOpacity(0.05),

              blurRadius: 10,

              offset: const Offset(0, 4),

            ),

          ],

        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Search Status Header

            Padding(

              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),

              child: Text(

                !_hasSearched

                    ? 'Recent Searches'

                    : _results.isEmpty

                        ? 'No results for your search'

                        : '${_results.length} results found',

                style: GoogleFonts.inter(

                  fontSize: 12,

                  fontWeight: FontWeight.w600,

                  color: Colors.grey[500],

                  letterSpacing: 0.5,

                ),

              ),

            ),



            if (_results.isNotEmpty)

              Expanded(

                child: ListView.builder(

                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  itemCount: _results.length,

                  itemBuilder: (_, index) {

                    final product = _results[index];

                    return Padding(

                      padding: const EdgeInsets.only(bottom: 8.0),

                      child: InkWell( // Now this will find the Material ancestor!

                        borderRadius: BorderRadius.circular(12),

                        onTap: () {

                          _toggle(false);

                          if (widget.onProductTap != null) {

                            widget.onProductTap!(product['id']);

                          } else {

                            Navigator.of(context).push(

                              MaterialPageRoute(

                                builder: (context) => ProductPage(

                                  product_id: product['id'],

                                  onQuantityChanged: (q) {},

                                ),

                              ),

                            );

                          }

                        },

                        child: Container(

                          padding: const EdgeInsets.all(8),

                          child: Row(

                            children: [

                              Container(

                                height: 60,

                                width: 60,

                                decoration: BoxDecoration(

                                  color: Colors.grey[100],

                                  borderRadius: BorderRadius.circular(8),

                                ),

                                child: ClipRRect(

                                  borderRadius: BorderRadius.circular(8),

                                  child: Image.network(

                                    product['image_url'] ?? '',

                                    fit: BoxFit.cover,

                                    errorBuilder: (c, e, s) => const Icon(Icons.chair, color: Colors.grey),

                                  ),

                                ),

                              ),

                              const SizedBox(width: 16),

                              Expanded(

                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    Text(

                                      product['name'],

                                      style: GoogleFonts.inter(

                                        fontWeight: FontWeight.w500,

                                        fontSize: 15,

                                      ),

                                    ),

                                    const SizedBox(height: 4),

                                    Text(

                                      'Rs${product['price'] ?? '0.00'}',

                                      style: GoogleFonts.inter(

                                        color: Colors.grey[600],

                                        fontSize: 13,

                                      ),

                                    ),

                                  ],

                                ),

                              ),

                              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),

                            ],

                          ),

                        ),

                      ),

                    );

                  },

                ),

              ),

          ],

        ),

      ),

    ),

  );

}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         GestureDetector(
          onTap: () {
                 final navigator = Navigator.of(context);

            bool homeFound = false;

            navigator.popUntil((route) {
              if (route.settings.name == '/home') {
                homeFound = true;
                return true; // stop popping
              }
              return false;
            });

            if (!homeFound) {
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(
                  settings: const RouteSettings(name: '/home'),
                  builder: (_) => const HomeScreen(),
                ),
                (_) => false,
              );
            }
          },
          child: SvgPicture.asset(
            'assets/images/furniLogo.svg',
            width: 120,
            height: 85,
          ),
        ),
        const Spacer(),
        if (_showSearch)
          SizedBox(
            width: 220,
            height: 36,
            child: TextField(
              controller: _controller,
              autofocus: true,
              onChanged: _onChanged,
              style: GoogleFonts.inter(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                isDense: true,
                prefixIcon: IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => _toggle(false),
                ),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          )
        else
          IconButton(
            icon: SvgPicture.asset('assets/images/search.svg', width: 24, height: 24),
            onPressed: () => _toggle(true),
          ),
      ],
    );
  }
}