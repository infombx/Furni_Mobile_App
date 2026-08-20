class CartItem {
  final String name;
  final String image;
  final double price;

  CartItem({required this.name, required this.image, required this.price});
}

class CartBucket {
  CartBucket({required this.items});
  CartBucket.forItems(List<CartItem> itemList) : items = List.from(itemList);
  final List<CartItem> items;
}
