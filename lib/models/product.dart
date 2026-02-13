class Product {
  final int id;
  final String name;
  final double price;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    const String baseUrl = 'http://159.65.15.249:1337';
    
    // According to your JSON sample:
    // 'title' and 'price' are at the root level of the object
    // 'featuredImage' is also at the root level
    final String? path = json['featuredImage']?['url'];

    return Product(
      id: json['id'],
      name: json['title'] ?? 'No Title',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: path != null ? '$baseUrl$path' : null,
    );
  }
}
