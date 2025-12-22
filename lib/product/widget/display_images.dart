import 'package:flutter/material.dart';

class DisplayImages extends StatefulWidget {
  const DisplayImages({super.key, required this.images});
  final List<String> images;

  @override
  State <DisplayImages> createState()=> _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages>{
  int current = 0;
   void swipeLeft (){
    setState(() {
      current = (((current - 1) + widget.images.length) % widget.images.length).toInt();
    });
   }
    void swipeRight (){
    setState(() {
      current = ((current + 1) % widget.images.length).toInt();
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
                child: Image.asset(widget.images[current], width: 311,height: 414,
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