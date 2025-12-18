import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furni_mobile_app/Items/bottomsheet.dart';
import 'package:furni_mobile_app/screens/cart_screen.dart';
// import 'package:furni_mobile_app/screens/profile_screen.dart';
// import 'package:furni_mobile_app/screens/shop_screen.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';
import 'package:furni_mobile_app/shop/shopPage.dart';

class GlassFloatingNavBar extends StatefulWidget {
  const GlassFloatingNavBar({super.key});

  @override
  State<GlassFloatingNavBar> createState() => _GlassFloatingNavBarState();
}

class _GlassFloatingNavBarState extends State<GlassFloatingNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 16,
          right: 16,
          bottom: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 25,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),

                child: BottomNavigationBar(
                  showSelectedLabels: false,     
                  showUnselectedLabels: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black54,
                  currentIndex: _selectedIndex,
                  onTap: (_) {}, // disable default navigation

                  items: [
                    BottomNavigationBarItem(
                      icon: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/images/home2.svg', height:24,
                        ),
                      ),
                      label: "Home",
                    ),

                    BottomNavigationBarItem(
                      icon: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Shoppage()),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/images/shop-page.svg',
                          width: 26,
                        ),
                      ),
                      label: "Shop",
                    ),
                    BottomNavigationBarItem(
                      icon: GestureDetector(
                        onTap: () {
                          
                          showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
  ),
  clipBehavior: Clip.antiAlias,
  builder: (ctx) => const BottomCartSheet(),
);

                          
                          
                          
                        },
                        child: SvgPicture.asset(
                          'assets/images/cart_logo.svg',
                          width: 26,
                        ),
                      ),
                      label: "Cart",
                    ),

                    BottomNavigationBarItem(
                      icon: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/images/user-circle.svg',
                          width: 26,
                        ),
                      ),
                      label: "Profile",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
