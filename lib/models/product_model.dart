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
    final attributes = json['attributes'];

    final imageData = attributes['image']?['data'];
    final imageUrl = imageData != null
        ? 'http://159.65.15.249:1337${imageData['attributes']['url']}'
        : '';

    return Product(
      id: json['id'],
      name: attributes['name'] ?? '',
      price: (attributes['price'] as num).toDouble(),
      imageUrl: imageUrl,
    );
  }
}
