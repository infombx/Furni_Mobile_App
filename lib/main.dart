import 'package:flutter/material.dart';
import 'package:furni_mobile_app/contactUs/contactus.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/screens/cart_screen.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';
import 'package:furni_mobile_app/screens/homme.dart';
import 'package:furni_mobile_app/screens/splash_screen.dart';
import 'package:furni_mobile_app/shop/shopPage.dart';
import 'package:furni_mobile_app/Header/header.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    )
  ),
     home:
     Scaffold(
        body: SafeArea(child: SplashScreen()),
      ),
  ),
);
}
