import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furni_mobile_app/Items/bottomsheet.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';
import 'package:furni_mobile_app/screens/my_account.dart';
import 'package:furni_mobile_app/shop/shopPage.dart';
import 'package:furni_mobile_app/navbar/slide_page_route.dart';

class GlassFloatingNavBar extends StatelessWidget {
  final int currentIndex;

  final VoidCallback? onHomeTap;

  const GlassFloatingNavBar({
    super.key,
    required this.currentIndex,
    this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 16,
          right: 16,
          bottom: 10,
          child: SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    currentIndex: currentIndex,
                    items: [
                      // ================= HOME =================
                      BottomNavigationBarItem(
                        icon: GestureDetector(
                          onTap: () {
                            if (currentIndex == 0) {
                              onHomeTap?.call();
                            } else {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.routeName,
                                (route) => false,
                              );
                            }
                          },

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/images/home2.svg',
                                height: 26,
                                colorFilter: ColorFilter.mode(
                                  currentIndex == 0
                                      ? Colors.black
                                      : Colors.black54,
                                  BlendMode.srcIn,
                                ),
                              ),
                              if (currentIndex == 0)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  height: 2,
                                  width: 15,
                                  color: Colors.black,
                                ),
                            ],
                          ),
                        ),
                        label: '',
                      ),

                      // ================= SHOP =================
                      BottomNavigationBarItem(
                        icon: GestureDetector(
                          onTap: () {
                            if (currentIndex != 1) {
                              Navigator.pushReplacement(
                                context,
                                SlidePageRoute(
                                  page: const Shoppage(),
                                  fromLeft: true, // LEFT → RIGHT
                                ),
                              );
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/images/shop-page.svg',
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  currentIndex == 1
                                      ? Colors.black
                                      : Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              if (currentIndex == 1)
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  height: 2,
                                  width: 15,
                                  color: Colors.black,
                                ),
                            ],
                          ),
                        ),
                        label: '',
                      ),

                      // ================= CART =================
                      BottomNavigationBarItem(
                        icon: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              builder: (_) => const BottomCartSheet(),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/images/cart_logo.svg',
                            width: 24,
                          ),
                        ),
                        label: '',
                      ),

                      // ================= PROFILE =================
                      BottomNavigationBarItem(
                        icon: GestureDetector(
                          onTap: () {
                            if (currentIndex != 3) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MyAccount(),
                                ),
                              );
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/images/user-circle.svg',
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 3 ? Colors.black : Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        label: '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}