import 'package:flutter/material.dart';
import 'package:furni_project/Items/counter.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget ({super.key});
  @override
  Widget build(BuildContext context){
    return
    Container(
        height: 300,
        child: Card(
         
          child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left:16),
                child: Container(
                height: 240,
                 width: 200,
                child: Image.asset('assets/images/sofa.png'!),
                //  child: product img
                ),
              ),
       

               Padding(
                 padding: const EdgeInsets.only(right: 3),
                 child: Column(
                  children: [
                    Text('Sofa'),
                    Text('Color:Green'),
                    QuantityCounter()
                  ],
                               ),
               ),
              Column(
                children: [
                  RichText(text:TextSpan(children:[TextSpan(text:'\$'), TextSpan(text:'20.00')] )),
                  IconButton(onPressed: (){}, icon: Icon(Icons.close))
                ],
              ),

             

          ],),
        ),
    )
    ;
  }
}