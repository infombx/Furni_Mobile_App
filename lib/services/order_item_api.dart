// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:furni_mobile_app/product/data/orders.dart';

// class OrderItemApi {
//   static const String _baseUrl =
//       'http://159.65.15.249:1337/api/order-items';

//   Future<int> createOrderItem(MyOrders item) async {
//     final response = await http.post(
//       Uri.parse(_baseUrl),
//       headers: const {
//         "Content-Type": "application/json",
//       },
//       body: jsonEncode({
//         "data": {
//           "quantity": item.quantity,
//           "colour": item.colorr.isNotEmpty
//               ? item.colorr.first
//               : "Default",
//           "product": item.product_id,
//         }
//       }),
//     );

//     if (response.statusCode != 200 && response.statusCode != 201) {
//       throw Exception(
//         "Failed to create OrderItem: ${response.body}",
//       );
//     }

//     final decoded = jsonDecode(response.body);
//     return decoded['data']['id'];
//   }
// }


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:furni_mobile_app/product/data/orders.dart';

// class OrderItemApi {
//   static const String _url =
//       'http://159.65.15.249:1337/api/order-items';

// Future<int> createOrderItem(MyOrders item, int orderId) async {
//   final response = await http.post(
//     Uri.parse('http://159.65.15.249:1337/api/order-items'),
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode({
//       "data": {
//         "quantity": item.quantity,
//         "colour": item.colorr.first,
//         "order": orderId, // ✅ THIS IS REQUIRED
//       }
//     }),
//   );

//   return jsonDecode(response.body)['data']['id'];
// }

// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furni_mobile_app/product/data/orders.dart';

class OrderItemApi {
  static const String _url =
      'http://159.65.15.249:1337/api/order-items';

  Future<int> createOrderItem({
    required MyOrders item,
    required int orderId,
  }) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: const {"Content-Type": "application/json","Authorization": "3d58939c2822591c6bde1f1e25d5ae556772b52930d3a888184a3b26cb16e41df945b5d86e75a451134b30a16356cc3932c55fd360edae44c571b47e8c19a4f0f3e2d0a8a4fda083eb18aa503de9f2b1a597d0d32cbbaea1df217bcbc386c04a810adb3e50099de94527eef0f66e4b9a6fec99677c2a87cdd7c21145e094b016"},
      body: jsonEncode({
        "data": {
          
          "quantity": item.quantity,
          "colour":
            item.colorr.isNotEmpty ? item.colorr.first : "Default",
         "order": { "id": orderId },
          "product": item.product_id,
        }
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception(
        "OrderItem error: ${response.body}",
      );
    }

    return jsonDecode(response.body)['data']['id'];
  }
}
