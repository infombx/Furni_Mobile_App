import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furni_mobile_app/product/data/orders.dart';
import 'package:furni_mobile_app/services/order_item_api.dart';

class OrderApi {
  final String _orderUrl = "http://159.65.15.249:1337/api/orders";
  final OrderItemApi _orderItemApi = OrderItemApi();

  Future<bool> createOrder({
    required Map<String, dynamic> addressData,
    required List<MyOrders> cartItems,
  }) async {
    try {
      final orderResponse = await http.post(
        Uri.parse(_orderUrl),
        headers: {"Content-Type": "application/json","Authorization": "3d58939c2822591c6bde1f1e25d5ae556772b52930d3a888184a3b26cb16e41df945b5d86e75a451134b30a16356cc3932c55fd360edae44c571b47e8c19a4f0f3e2d0a8a4fda083eb18aa503de9f2b1a597d0d32cbbaea1df217bcbc386c04a810adb3e50099de94527eef0f66e4b9a6fec99677c2a87cdd7c21145e094b016" },
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

      if (orderResponse.statusCode != 200 && orderResponse.statusCode != 201) {
        print("❌ Failed to create order: ${orderResponse.body}");
        return false;
      }

      // Extract the order ID
      final orderId = jsonDecode(orderResponse.body)['data']['id'];

      // 2️⃣ CREATE ORDER ITEMS linked to this order
      for (final item in cartItems) {
        await _orderItemApi.createOrderItem(
          item: item,
          orderId: orderId,
        );
      }

      print("✅ Order and items created successfully");
      return true;
    } catch (e) {
      print("❌ ORDER ERROR: $e");
      return false;
    }
    
    
  }
}
