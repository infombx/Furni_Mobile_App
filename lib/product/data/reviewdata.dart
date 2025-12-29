class ReviewWeb {
  final int id;
  final String name;
  final String comment;
  final int rating;
  final DateTime date;
  final String pictureUrl; // Changed to String for the URL
  final List<String> productId;

  ReviewWeb({
    required this.id,
    required this.name,
    required this.comment,
    required this.rating,
    required this.date,
    required this.pictureUrl,
    required this.productId,
  });

  factory ReviewWeb.fromJson(Map<String, dynamic> json) {
    // Access the nested ProductId inside the productId object
    final productData = json['productId'];
    final String actualId = productData != null
        ? productData['ProductId'] ?? ''
        : '';

    return ReviewWeb(
      id: json['id'],
      name: json['name'] ?? 'Anonymous',
      comment: json['Comment'] ?? '',
      rating: (json['rating'] ?? 0) as int,
      date: DateTime.parse(json['Date'] ?? DateTime.now().toIso8601String()),
      pictureUrl: json['pfp'] ?? 'https://via.placeholder.com/150',
      productId: [
        actualId,
      ], // Store it as a list if you prefer your current structure
    );
  }
}
