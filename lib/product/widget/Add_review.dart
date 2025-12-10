import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furni_mobile_app/product/widget/rating_star.dart';

class AddReview extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Reviews',
            style: 
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            
            ),
          ),
          SizedBox(height: 10,),
          Container(child: Row(
            children: [
              RatingStar(),
              SizedBox(width: 10,),
              Text('11 reviews')
            ],
          )),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tray Table', style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),),
            ],
          ),
          SizedBox(
            height: 30,
          ),
         
              Container(
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color.fromARGB(255, 224, 224, 224), width: 1.5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Expanded(
                        child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Share your thoughts',
                          border: InputBorder.none
                        ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: -5,
                        child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_right, color: const Color.fromARGB(255, 37, 37, 37), size: 39,)))
                    ],
                  ),
                ),
              )
          
        ],
        )
    );
  }

}