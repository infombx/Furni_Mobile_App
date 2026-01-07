class Product {
  final int id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handling Strapi's nested structure or standard JSON
    String catName = 'General';
    if (json['category'] != null) {
      catName = json['category']['name'] ?? 'General';
    }

    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: catName,
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}