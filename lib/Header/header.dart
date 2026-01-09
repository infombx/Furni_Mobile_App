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

  // --- NAVIGATION & OVERLAY LOGIC ---

  void _safeNavigate(VoidCallback action) {
    _removeOverlay();
    _toggle(false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      action();
    });
  }

  void _onLogoTap(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == HomeScreen.routeName) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.routeName,
      (route) => false,
    );
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

  // --- UI BUILDERS ---

  Widget _buildOverlay() {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 0, // TAKES THE WHOLE PAGE
      left: 0,
      right: 0,
      bottom: 0,
      child: Material(
        color: Colors.white, // Full white background
        child: SafeArea(
          child: Column(
            children: [
              // Search Input inside the overlay
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          onChanged: _onChanged,
                          style: GoogleFonts.inter(fontSize: 15),
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            prefixIcon: const Icon(Icons.search, size: 20),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () => _toggle(false),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Results Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      !_hasSearched
                          ? 'RECENT SEARCHES'
                          : _results.isEmpty && !_isLoading
                              ? 'NO RESULTS FOUND'
                              : '${_results.length} RESULTS FOUND',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[400],
                        letterSpacing: 1.2,
                      ),
                    ),
                    if (_isLoading)
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                      ),
                  ],
                ),
              ),

              // Scrollable Results
              Expanded(
                child: _results.isEmpty && _hasSearched && !_isLoading
                ? _buildNoResults()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _results.length,
                    itemBuilder: (_, index) {
                      final product = _results[index];
                      return _buildProductItem(product);
                    },
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'We couldn\'t find what you\'re looking for.',
            style: GoogleFonts.inter(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _safeNavigate(() {
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
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
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
                        fontWeight: FontWeight.w600, 
                        fontSize: 16,
                        color: Colors.black87
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rs ${product['price']}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[600], 
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[300], size: 16),
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
          onTap: () => _onLogoTap(context),
          child: SvgPicture.asset(
            'assets/images/furniLogo.svg',
            width: 120,
            height: 85,
          ),
        ),
        const Spacer(),
        // Only the Search Icon is needed here now, 
        // as the actual text field is inside the full-page overlay
        IconButton(
          icon: SvgPicture.asset('assets/images/search.svg', width: 24, height: 24),
          onPressed: () => _toggle(true),
        ),
      ],
    );
  }
}