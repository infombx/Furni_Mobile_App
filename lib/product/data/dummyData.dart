import 'package:furni_mobile_app/services/api_dummydata.dart';
class Product {
  final int id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String measurements;
  final List<String> colours;
  final List<String> images;
  final String display_image;
  final int quantity;
  final int rating;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.measurements,
    required this.colours,
    required this.images,
    required this.quantity,
    required this.rating,
    required this.display_image
  });
factory Product.fromJson(Map<String, dynamic> json) {
  // Helper to extract nested text from the complex description list
  String parseDescription(dynamic descData) {
    if (descData is List) {
      return descData.map((paragraph) {
        if (paragraph['children'] is List) {
          return (paragraph['children'] as List)
              .map((child) => child['text'] ?? '')
              .join('');
        }
        return '';
      }).join('\n');
    }
    return descData?.toString() ?? '';
  }

  // Helper to construct image URLs safely
  String parseImage(dynamic link) {
    if (link == null || link.toString().trim().isEmpty) {
      return 'https://via.placeholder.com/150'; // Fallback
    }
    String cleanLink = link.toString().trim();
    if (cleanLink.startsWith('http')) return cleanLink;
    return 'http://159.65.15.249:1337/uploads/$cleanLink';
  }

  return Product(
    id: json['id'] ?? 0,
    name: json['title'] ?? 'Unnamed',
    category: json['category'] ?? '', // Match your JSON key
    description: parseDescription(json['description']), // Prevents "JsonMap is not a subtype of String"
    measurements: json['measurement'] ?? '',
    price: (json['price'] ?? 0).toDouble(),
    quantity: json['stock'] ?? 0,
    rating: json['rating'] ?? 0,
    display_image: parseImage(json['featuredImageLink']), // Prevents "Null is not a subtype of Map"
    images: [parseImage(json['featuredImageLink'])],
    colours: [], 
  );
}
}

final List<String> category = [
  "All",
  "Kitchen",
  "Living Room",
  "Bedroom",
  "Bathroom",
  "Dining Room",
  "Office"
];
