import 'package:flutter/material.dart';

class DisplayImages extends StatefulWidget {
  @override
  State <DisplayImages> createState()=> _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages>{
  int current = 0;
  List<String> images = [
    'assets/images/product_image_4.png',
    'assets/images/product_image_1.jpg',
    'assets/images/product_image_2.jpg',
    'assets/images/product_image_3.jpg',
    'assets/images/product_image_5.jpg'

  ];
   void swipeLeft (){
    setState(() {
      current = ((current -1)+ images.length)% images.length;
    });
   }
    void swipeRight (){
    setState(() {
      current = (current +1)% images.length;
    });
   }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(images[current], width: 311,height: 414,
                fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: -5,
                child: IconButton(
                      onPressed: swipeLeft,
                      icon: Image.asset(
                      'assets/images/Left_arrow.png',
                      width: 60,
                    ),
                  )
              ),
               Positioned(
                right: -5,
                 child: IconButton(
                      onPressed: swipeRight,
                      icon: Image.asset(
                      'assets/images/Right_arrow.png',
                      width: 60,
                    ),
                  )
              )
      
            ],
          )
      ),
    );
  }

}