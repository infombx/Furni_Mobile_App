import 'package:flutter/material.dart';
import 'package:furni_mobile_app/contactUs/widget/services.dart';
import 'package:furni_mobile_app/home_page/about_us.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/home_page/bundle.dart';
import 'package:furni_mobile_app/home_page/carousel.dart';
import 'package:furni_mobile_app/home_page/newproduct.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Header(), automaticallyImplyLeading: false,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              CarouselWidget(),
              Bundle(),
              NewArrival(),
              AboutUsSection(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Services(),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:  SizedBox(height: 90, child: GlassFloatingNavBar(),),
    );
  }
}
