import 'package:flutter/material.dart';
import 'package:furni_mobile_app/Header/header.dart';
import 'package:furni_mobile_app/dummy%20items/myItems.dart';
import 'package:furni_mobile_app/navbar/navbar.dart';
import 'package:furni_mobile_app/product/data/dummyData.dart';
import 'package:furni_mobile_app/product/widget/Add_review.dart';
import 'package:furni_mobile_app/product/widget/details_card.dart';
import 'package:furni_mobile_app/product/widget/display_images.dart';
import 'package:furni_mobile_app/product/widget/navigation.dart';
import 'package:furni_mobile_app/product/widget/review.dart';
import 'package:furni_mobile_app/services/api_dummydata.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.onQuantityChanged, required this.product_id});
  final void Function(int) onQuantityChanged;
  final int product_id;
  @override
  Widget build(BuildContext context) {
  
    return  FutureBuilder<List<Product>>(
      future: ApiService.fetchProducts(),
      builder: (context, snapshot) {
          final product = snapshot.data!
            .firstWhere((p) => p.id == product_id);
        return Scaffold(
          appBar: AppBar(
            title: Header(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Navigation(),
                        SizedBox(height: 16),
                        SizedBox(height: 414, width: 311, child: DisplayImages(images: product.images)),
                        SizedBox(height: 16),
                        DetailsCard(
                        name:  product.name, 
                        category: product.category, 
                        colours: product.colours, 
                        description: product.description, 
                        measurements: product.measurements, 
                        price: product.price, 
                        rating: product.rating, 
                        quantity: product.quantity),
                        SizedBox(height: 20),
                        Divider(thickness: 1.5),
                        SizedBox(height: 15),
                        AddReview(),
                        SizedBox(height: 20),
                        Review(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(height: 90,child: GlassFloatingNavBar(),),
        );
      }
    );
  }
}
