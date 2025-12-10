import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  const QuantityCounter({super.key});

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  int quantity = 1; 

  void addCounter() {
    setState(() {
      quantity += 1;
    });
  }

  void minCounter() {
    setState(() {
      if (quantity > 1) { 
        quantity -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 40,
            child: IconButton(
              onPressed: minCounter, 
              icon: Transform.translate(offset: Offset(0, -7),
              child: Icon(Icons.minimize, size: 24,),)
            ),
          ),
          Text(
            '$quantity',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            width: 40,
            child: TextButton(
              onPressed: addCounter, 
              child: Icon(Icons.add, color: Colors.black, size: 25,),
            ),
          ),
        ],
      ),
    );
  }
}

