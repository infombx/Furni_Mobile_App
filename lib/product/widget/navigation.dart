import 'package:flutter/material.dart';

class Navigation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Home', style: TextStyle(color: const Color.fromARGB(255,96, 95, 95), fontSize: 14),),
        SizedBox(width: 4,),
        Icon(Icons.keyboard_arrow_right_outlined, size: 14,color:  const Color.fromARGB(255, 95, 95, 95)),
        SizedBox(width: 4,),
        Text('Shop', style: TextStyle(color:  const Color.fromARGB(255,96, 95, 95), fontSize: 14),),
        SizedBox(width: 4,),
        Icon(Icons.keyboard_arrow_right_outlined, size: 14,color:  const Color.fromARGB(255, 95, 95, 95)),
        SizedBox(width: 4,),
         Text('Category', style: TextStyle(color:  const Color.fromARGB(255, 95, 95, 95), fontSize: 14),),
         SizedBox(width: 4,),
        Icon(Icons.keyboard_arrow_right_outlined, size: 14,color:  const Color.fromARGB(255, 95, 95, 95)),
        SizedBox(width: 4,),
        Text('Product', style: TextStyle(color:  const Color.fromARGB(255, 18, 18, 18), fontSize: 14),),
      ],

    );
  }
}