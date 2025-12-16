import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/contactUs/contactus.dart';
import 'package:furni_mobile_app/contactUs/widget/location.dart';
import 'package:furni_mobile_app/data/data_cons.dart';
import 'package:furni_mobile_app/data/dummy_data.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/product/Product_page.dart';
import 'package:furni_mobile_app/screens/cart_screen.dart';
import 'package:furni_mobile_app/screens/home_screen.dart';
import 'package:furni_mobile_app/shop/shopPage.dart';
import 'package:furni_mobile_app/shop/widget/filternav.dart';
import 'package:furni_mobile_app/shop/widget/grid.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
     home:
     Scaffold(
  appBar: AppBar(
      // automaticallyImplyLeading: false,
      title: Header(),
  ),
  // extendBody: true,
  body: SafeArea(child: Shoppage()),
  bottomNavigationBar: SizedBox(height:90, child:GlassFloatingNavBar(), ) 
      ),
  ),
);
}


