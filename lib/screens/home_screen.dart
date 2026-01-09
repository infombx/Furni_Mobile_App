import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/home_page/carousel.dart';
import 'package:furni_mobile_app/home_page/bundle.dart';
import 'package:furni_mobile_app/home_page/newproduct.dart';
import 'package:furni_mobile_app/home_page/about_us.dart';
import 'package:furni_mobile_app/contactUs/widget/services.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';

class HomeScreen extends StatefulWidget {
  static final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
      static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  // ✅ ENHANCED REFRESH LOGIC
  // ✅ PLACE IT HERE (Inside the State, but before the build method)
  Future<void> _handleRefresh() async {
    await Future.wait([
      Future.delayed(const Duration(seconds: 2)),
      // Add your API call here like: ApiService().getProducts(),
    ]);

    if (mounted) {
      setState(() {
        // This triggers the build method to refresh the UI
      });
    }
  }

  // ✅ Show the pull-down animation
  void showPullDownRefresh() {
    // Scroll slightly down first
    _scrollController
        .animateTo(
          -80, // distance to reveal the RefreshIndicator
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        )
        .then((_) {
          HomeScreen.refreshIndicatorKey.currentState?.show();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Header(), automaticallyImplyLeading: false),
      body: Stack(
        children: [
          // Main scrollable content
          SafeArea(
            child: RefreshIndicator(
              key: HomeScreen.refreshIndicatorKey,
              onRefresh: _handleRefresh,
              displacement: 60,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 300, child: CarouselWidget()),
                    const Bundle(),
                    const NewArrival(),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const Services(),
                    ),
                    const SizedBox(height: 20),
                    const AboutUsSection(),
                    const SizedBox(height: 100), // space for navbar
                  ],
                ),
              ),
            ),
          ),

          // Floating Glass Navbar
           GlassFloatingNavBar(currentIndex: 0, onHomeTap: showPullDownRefresh,),
        ],
      ),
    );
  }
}