import 'package:flutter/material.dart';
import 'package:teakworld/home_page/shopNow_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teakworld/home_page/data/bundle.dart';
import 'package:teakworld/services/api_bundle.dart';
import 'package:teakworld/shop/Shoppage.dart';

class Bundle extends StatefulWidget {
  const Bundle({super.key});

  @override
  State<Bundle> createState() => _BundleState();
}

class _BundleState extends State<Bundle> {
  static const String baseUrl = "http://159.65.15.249:1337";
  Future<List<BundleModel>>? _bundleFuture;

  @override
  void initState() {
    super.initState();
    _bundleFuture = ApiService.fetchBundles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BundleModel>>(
      future: _bundleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final bundles = snapshot.data ?? [];
        if (bundles.isEmpty) return const SizedBox.shrink();

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            if (width >= 600) {
              // TABLET + DESKTOP
              return _horizontalLayout(bundles, isDesktop: width >= 1024);
            } else {
              // MOBILE
              return _mobileLayout(bundles);
            }
          },
        );
      },
    );
  }

  // ================= HORIZONTAL LAYOUT =================
  Widget _horizontalLayout(List<BundleModel> bundles,
      {required bool isDesktop}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 16,
        vertical: 16,
      ),
      child: SizedBox(
        height: isDesktop ? 420 : 360,
        child: Row(
          children: List.generate(
            bundles.length.clamp(0, 3),
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == 2 ? 0 : (isDesktop ? 24 : 16),
                ),
                child: _buildBundleCard(
                  bundles[index],
                  isLarge: isDesktop,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= MOBILE =================
  Widget _mobileLayout(List<BundleModel> bundles) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: bundles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 220,
          child: _buildBundleCard(
            bundles[index],
            isLarge: false,
          ),
        );
      },
    );
  }

  // ================= CARD =================
  Widget _buildBundleCard(BundleModel bundle, {required bool isLarge}) {
    final imageUrl = '$baseUrl${bundle.imageUrl}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Shoppage(selectedCategory: bundle.title),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, card) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3F5F7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    right:10,
                    child: SizedBox(
                      width: card.maxWidth * 0.99,
                      height: card.maxHeight * 0.95,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomRight,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.chair_alt, size: 40),
                      ),
                    ),
                  ),
                            Positioned(
                              top: 0,
                              left: 0,

                    child: Padding(
                      padding: EdgeInsets.all(isLarge ? 20 : 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bundle.title,
                            style: GoogleFonts.poppins(
                              fontSize: isLarge ? 24 : 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const ShopNowLink(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
