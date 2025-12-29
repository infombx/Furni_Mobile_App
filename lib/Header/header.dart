import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    try {
      final url =
          'http://159.65.15.249:1337/api/products?filters[title][\$containsi]=$trimmed';

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final body = json.decode(res.body);
        final List data = body['data'] ?? [];

        final results = data.map<Map<String, dynamic>>((e) {
          return {'id': e['id'], 'name': e['title'] ?? 'Unknown'};
        }).toList();

        setState(() {
          _results = results;
          _hasSearched = true;
        });
      } else {
        setState(() {
          _results = [];
          _hasSearched = true;
        });
      }
    } catch (_) {
      setState(() {
        _results = [];
        _hasSearched = true;
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
      _updateOverlay();
    }
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = OverlayEntry(builder: (_) => _buildOverlay());
    Overlay.of(context, rootOverlay: true)!.insert(_overlayEntry!);
  }

  void _updateOverlay() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildOverlay() {
    final double appBarHeight =
        kToolbarHeight + MediaQuery.of(context).padding.top;

    return Positioned.fill(
      child: Stack(
        children: [
          // 🔹 Soft dark background
          GestureDetector(
            onTap: () => _toggle(false),
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),

          // 🔹 Blended results panel
          Positioned(
            top: appBarHeight,
            left: 12,
            right: 12,
            bottom: 12,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[100], // 👈 NOT pure white
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      !_hasSearched
                          ? 'Type to search products...'
                          : _results.isEmpty
                          ? 'No products found'
                          : 'Found ${_results.length} products',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  if (_results.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: _results.length,
                        itemBuilder: (_, index) {
                          final product = _results[index];

                          return Card(
                            elevation: 0,
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(product['name']),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              ),
                              onTap: () {
                                _toggle(false);
                                widget.onProductTap?.call(product['id']);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/furniLogo.svg', width: 120, height: 55),
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
                prefixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _toggle(false),
                ),
                suffixIcon: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : const Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          )
        else
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/search.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () => _toggle(true),
          ),
      ],
    );
  }
}
