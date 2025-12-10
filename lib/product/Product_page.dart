import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/product/widget/Add_review.dart';
import 'package:furni_mobile_app/product/widget/details_card.dart';
import 'package:furni_mobile_app/product/widget/display_images.dart';
import 'package:furni_mobile_app/product/widget/navigation.dart';
import 'package:furni_mobile_app/product/widget/review.dart';
import 'package:furni_mobile_app/widgets/footer/footer.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Header(),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                     Navigation(),
                     SizedBox(height: 16,),
                     Container(
                      height: 414,
                      width: 311,
                      child: DisplayImages()
                      ),
                     SizedBox(height: 16,),
                     DetailsCard(),
                     SizedBox(height: 20,),
                     Divider(thickness: 1.5,),
                      SizedBox(height: 15,),
                     AddReview(),
                      SizedBox(height: 20,),
                     Review()
                     
                  ],
                ),
              ),
            ),
            FooterWidget()
          ],
        ),
      ),
    );
  }
}