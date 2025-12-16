import 'package:flutter/material.dart';
import 'package:furni_mobile_app/data/dummy_data.dart';
import 'package:furni_mobile_app/shop/widget/filternav.dart';
import 'package:furni_mobile_app/shop/widget/grid.dart';
import 'package:furni_mobile_app/shop_page/hero_section.dart';

class Shoppage extends StatelessWidget{
  const Shoppage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              HeroSection(),
              SizedBox(height: 10,),
              Filternav(),
              SizedBox(height: 10,),
              ProductGrid(items: dummyData,)
            ]
          ),
        ),
      );
  }
}