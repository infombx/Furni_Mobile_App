import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furni_mobile_app/home_page/shopNow_widget.dart';
import 'package:furni_mobile_app/home_page/data/bundle.dart';
import 'package:furni_mobile_app/services/api_bundle.dart';
import 'package:furni_mobile_app/shop/shoppage.dart'; 

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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final bundles = snapshot.data ?? [];

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bundles.length,
          itemBuilder: (context, index) {
            final bundle = bundles[index];
            final fullImageUrl = '$baseUrl${bundle.imageUrl}';

            return GestureDetector(
              onTap: () {
                // Navigate to ShopPage with the category filter
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Shoppage(selectedCategory: bundle.title),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      Image.network(
                        fullImageUrl,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned(
                          top: 20,
                          left: 10,
                          child: Text(bundle.title,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ))),
                      const Positioned(
                          top: 50, left: 10, child: ShopNowLink()),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}