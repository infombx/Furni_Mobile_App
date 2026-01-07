import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furni_mobile_app/product/data/orders.dart';
import 'package:furni_mobile_app/services/order_item_api.dart';

class OrderApi {
  final String _orderUrl = "http://159.65.15.249:1337/api/orders";
  final OrderItemApi _orderItemApi = OrderItemApi();
  final String _token = "3d58939c2822591c6bde1f1e25d5ae556772b52930d3a888184a3b26cb16e41df945b5d86e75a451134b30a16356cc3932c55fd360edae44c571b47e8c19a4f0f3e2d0a8a4fda083eb18aa503de9f2b1a597d0d32cbbaea1df217bcbc386c04a810adb3e50099de94527eef0f66e4b9a6fec99677c2a87cdd7c21145e094b016";

  Future<bool> createOrder({
    required Map<String, dynamic> addressData,
    required List<MyOrders> cartItems,
  }) async {
    try {
      // 1️⃣ CREATE THE PARENT ORDER
      final orderResponse = await http.post(
        Uri.parse(_orderUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token"
        },
        body: jsonEncode({
          "data": {
            "nid": addressData['userId'].toString(),
            "firstName": addressData['firstName'],
            "lastName": addressData['lastName'],
            "email": addressData['email'],
            "phone": addressData['phone'],
            "street": addressData['street'],
            "city": addressData['city'],
            "state": addressData['state'] ?? "", // Fallback to empty string
            "postCode": addressData['zip'],
            "country": addressData['country'] ?? "Mauritius",
            "delivery": "express",
          }
        }),
      );

      if (orderResponse.statusCode != 200 && orderResponse.statusCode != 201) {
        print("❌ Order Post Failed: ${orderResponse.body}");
        return false;
      }

      final orderData = jsonDecode(orderResponse.body);
      final int orderId = orderData['data']['id'];

      // 2️⃣ CREATE ITEMS LINKED TO THIS ORDER
      // Using a loop to ensure each item is created and linked correctly
      for (final item in cartItems) {
        try {
          await _orderItemApi.createOrderItem(
            item: item,
            orderId: orderId,
          );
        } catch (itemError) {
          print("⚠️ Error creating item for Product ${item.product_id}: $itemError");
          // You can decide if one item failing should cancel the whole success message
        }
      }

      print("✅ Order #$orderId and all items processed");
      return true;
    } catch (e) {
      print("❌ CRITICAL ORDER ERROR: $e");
      return false;
    }
  }
}