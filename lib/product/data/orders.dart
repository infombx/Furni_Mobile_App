
// import 'package:flutter/material.dart';

// class MyOrders {
//   MyOrders({
//     required this.product_id, 
//     required this.image, 
//     required this.quantity, 
//     required this.description,
//      required this.price,
//      required this.colorr,
//      required this.name,
//      required this.userId,
//      required this.measurement
//      });
//      int product_id;
//      String image;
//      int quantity;
//      String description;
//      double price;
//      List<String> colorr;
//      String name;
//      int userId;
//      String measurement;
     
    
//      Map<String, dynamic> toJson() => {
//     'product_id': product_id,
//     'image': image,
//     'quantity': quantity,
//     'description': description,
//     'price': price,
//     'colorr': colorr,
//     'name': name,
//     'userId': userId,
//     'measurement': measurement
//   };
  
//   factory MyOrders.fromJson(Map<String, dynamic> json) => MyOrders(
//     product_id: json['product_id'],
//     image: json['image'],
//     quantity: json['quantity'],
//     description: json['description'],
//     price: (json['price']as num).toDouble(),
//     colorr: List<String>.from(json['colorr']),
//     name: json['name'],
//     userId: json['userId'],
//     measurement: json['measurement']
//   );




// }

// List<MyOrders> ordersList =[

// ];
// // List<MyOrders> userCart = ordersList.where((order) => order.userId == "user_123").toList();
// orders.dart
class MyOrders {
  MyOrders({
    required this.product_id,
    required this.image,
    required this.quantity,
    required this.description,
    required this.price,
    required this.colorr,
    required this.name,
    required this.userId,
    required this.measurement,
  });

  final int product_id;
  final String image;
  int quantity;
  final String description;
  final double price;
   List<String> colorr;
  final String name;
  final int userId;
  final String measurement;

  Map<String, dynamic> toJson() => {
        'product_id': product_id,
        'image': image,
        'quantity': quantity,
        'description': description,
        'price': price,
        'colorr': colorr,
        'name': name,
        'userId': userId,
        'measurement': measurement,
      };

  factory MyOrders.fromJson(Map<String, dynamic> json) => MyOrders(
        product_id: json['product_id'],
        image: json['image'],
        quantity: json['quantity'],
        description: json['description'],
        price: (json['price'] as num).toDouble(),
        colorr: List<String>.from(json['colorr']),
        name: json['name'],
        userId: json['userId'],
        measurement: json['measurement'],
      );
}

/// MUST NOT be final
List<MyOrders> ordersList = [];
