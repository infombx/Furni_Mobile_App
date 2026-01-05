// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:furni_mobile_app/product/data/orders.dart';

// class OrderApi {
//   final String apiUrl = "http://159.65.15.249:1337/api/orders";

//   Future<bool> createOrder({
//     required Map<String, dynamic> addressData,
//     required List<MyOrders> cartItems,
//   }) async {
//     try {
//       // ✅ STEP 1: Build order_items FIRST
//       final List<Map<String, dynamic>> orderItems = [];

//       for (final item in cartItems) {
//         orderItems.add({
//           "quantity": int.parse(item.quantity.toString()),
//           "colour": item.colorr.isNotEmpty
//               ? item.colorr.first
//               : "Default",
//           "product": int.parse(item.product_id.toString()),
//         });
//       }

//       // ✅ STEP 2: Build request body
//       final Map<String, dynamic> requestBody = {
//         "data": {
//           "nid": addressData['userId'].toString(),
//           "firstName": addressData['firstName'],
//           "lastName": addressData['lastName'],
//           "email": addressData['email'],
//           "phone": addressData['phone'],
//           "street": addressData['street'],
//           "city": addressData['city'],
//           "state": addressData['state'],
//           "postCode": addressData['zip'],
//           "country": addressData['country'] ?? "Mauritius",
//           "delivery": "express",
//           "order_items": orderItems, // ✅ now valid
//         }
//       };

//       // ✅ STEP 3: Send request
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: const {
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode(requestBody),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print("✅ Order created successfully");
//         return true;
//       } else {
//         print("❌ Server Error Code: ${response.statusCode}");
//         print("❌ Server Response: ${response.body}");
//         return false;
//       }
//     } catch (e) {
//       print("❌ Network / Parsing Error: $e");
//       return false;
//     }
//   }
// }


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:furni_mobile_app/product/data/orders.dart';
// import 'package:furni_mobile_app/services/order_item_api.dart';

// class OrderApi {
//   static const String _url =
//       "http://159.65.15.249:1337/api/orders";

//   final OrderItemApi _itemApi = OrderItemApi();

//   Future<bool> createOrder({
//     required Map<String, dynamic> addressData,
//     required List<MyOrders> cartItems,
//   }) async {
//     try {
//       final List<int> orderItemIds = [];

//       for (final item in cartItems) {
//         orderItemIds.add(
//           await _itemApi.createOrderItem(item, ),
//         );
//       }

//       final response = await http.post(
//         Uri.parse(_url),
//         headers: const {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "data": {
//             "nid": addressData['userId'].toString(),
//             "firstName": addressData['firstName'],
//             "lastName": addressData['lastName'],
//             "email": addressData['email'],
//             "phone": addressData['phone'],
//             "street": addressData['street'],
//             "city": addressData['city'],
//             "state": addressData['state'],
//             "postCode": addressData['zip'],
//             "country": addressData['country'],
//             "delivery": "express",

//             // ✅ RELATION → IDs ONLY
//             "order_items": orderItemIds,
//           }
//         }),
//       );

//       return response.statusCode == 200 ||
//           response.statusCode == 201;
//     } catch (e) {
//       print("ORDER ERROR: $e");
//       return false;
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furni_mobile_app/product/data/orders.dart';
import 'package:furni_mobile_app/services/order_item_api.dart';

class OrderApi {
  static const String _url = "http://159.65.15.249:1337/api/orders";
  final OrderItemApi _itemApi = OrderItemApi();

  Future<bool> createOrder({
    required Map<String, dynamic> addressData,
    required List<MyOrders> cartItems,
  }) async {
    try {
      // 1️⃣ CREATE ORDER FIRST (without order_items)
      final orderResponse = await http.post(
        Uri.parse(_url),
        headers: {"Content-Type": "application/json","Authorization": "3d58939c2822591c6bde1f1e25d5ae556772b52930d3a888184a3b26cb16e41df945b5d86e75a451134b30a16356cc3932c55fd360edae44c571b47e8c19a4f0f3e2d0a8a4fda083eb18aa503de9f2b1a597d0d32cbbaea1df217bcbc386c04a810adb3e50099de94527eef0f66e4b9a6fec99677c2a87cdd7c21145e094b016"},
        body: jsonEncode({
          "data": {
            "nid": addressData['userId'].toString(),
            "firstName": addressData['firstName'],
            "lastName": addressData['lastName'],
            "email": addressData['email'],
            "phone": addressData['phone'],
            "street": addressData['street'],
            "city": addressData['city'],
            "state": addressData['state'],
            "postCode": addressData['zip'],
            "country": addressData['country'] ?? "Mauritius",
            "delivery": "express",
          }
        }),
      );

      if (orderResponse.statusCode != 200 &&
          orderResponse.statusCode != 201) {
        print("❌ Failed to create order: ${orderResponse.body}");
        return false;
      }

      final orderId = jsonDecode(orderResponse.body)['data']['id'];

      // 2️⃣ CREATE ORDER ITEMS AND COLLECT THEIR IDS
      final List<int> orderItemIds = [];
      for (final item in cartItems) {
        final id = await _itemApi.createOrderItem(
          item: item,
          orderId: orderId,
          
        );
        orderItemIds.add(id);
      }

      // 3️⃣ UPDATE ORDER TO LINK ORDER ITEMS
      final updateResponse = await http.put(
        Uri.parse("$_url/$orderId"),
        
        headers: {"Content-Type": "application/json","Authorization": "3d58939c2822591c6bde1f1e25d5ae556772b52930d3a888184a3b26cb16e41df945b5d86e75a451134b30a16356cc3932c55fd360edae44c571b47e8c19a4f0f3e2d0a8a4fda083eb18aa503de9f2b1a597d0d32cbbaea1df217bcbc386c04a810adb3e50099de94527eef0f66e4b9a6fec99677c2a87cdd7c21145e094b016",},
        
        body: jsonEncode({
          "data": {
            "order_items": {"connect": orderItemIds}
          }
        }),
      );

      if (updateResponse.statusCode != 200 &&
          updateResponse.statusCode != 201) {
        print("❌ Failed to link order items: ${updateResponse.body}");
        return false;
      }

      print("✅ Order and order items created successfully");
      return true;
    } catch (e) {
      print("❌ ORDER ERROR: $e");
      return false;
    }
  }
}
