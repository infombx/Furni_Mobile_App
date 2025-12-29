class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    final image = attr['image']['data'];

    return Product(
      id: json['id'],
      name: attr['name'],
      price: (attr['price'] as num).toDouble(),
      imageUrl: image != null
          ? 'http://159.65.15.249:1337${image['attributes']['url']}'
          : '',
    );
  }
}
