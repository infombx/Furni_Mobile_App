import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/home_page/carousel.dart';
import 'package:furni_mobile_app/home_page/bundle.dart';
import 'package:furni_mobile_app/home_page/new_arrival.dart';
import 'package:furni_mobile_app/home_page/about_us.dart';
import 'package:furni_mobile_app/contactUs/widget/services.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/product/product_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Header(), automaticallyImplyLeading: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
             const SizedBox(
              height: 300, 
              child: CarouselWidget()
             ),
              const Bundle(),
              const NewArrival(),
              const SizedBox(height: 10),
              
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: const Services()), 
              
              const SizedBox(height: 20),
              const AboutUsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SizedBox(height: 90, child: GlassFloatingNavBar()),
    );
  }

  // ✅ Wrap each widget to catch errors
  Widget _safeWidget(Widget child, String name) {
    try {
      print('🔷 Rendering: $name');
      return child;
    } catch (e, stackTrace) {
      print('❌ Error in $name: $e');
      print('Stack trace: $stackTrace');
      return Container(
        padding: const EdgeInsets.all(16),
        color: Colors.red[100],
        child: Column(
          children: [
            Text(
              'Error in $name',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(e.toString(), style: const TextStyle(fontSize: 12)),
          ],
        ),
      );
    }
  }
}

