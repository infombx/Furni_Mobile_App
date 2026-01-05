import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:furni_mobile_app/product/data/orders.dart';

class CartPersistence {
  static const String _key = 'user_cart_items';

  static Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      ordersList.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(_key, encoded);
  }

  static Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_key);

    if (encoded == null) return;

    final List list = jsonDecode(encoded);
    ordersList = list
        .map((e) => MyOrders.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
