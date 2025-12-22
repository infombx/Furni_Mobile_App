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
  String _parseImage(dynamic link) {
  if (link == null) return '';

  if (link.startsWith('http')) {
    return link;
  }

  // If later you convert it to Strapi uploads
  return 'http://159.65.15.249:1337/uploads/$link';
}

  return Product(
    id: json['id'] ?? 0,

    name: json['title'] ?? 'Unnamed product',

    measurements: json['measurement'] ?? '',

    price: (json['price'] ?? 0).toDouble(),

    quantity: 1,

    rating: json['stock'] ?? 0,

    display_image: _parseImage(json['featuredImageLink']),

    category:  json['product_category'], 

    images: json ['images'],

    description: json['description'],

    colours: json['colour'] ?? 0,

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


class ProductBucket {
  ProductBucket({required this.items});
  ProductBucket.forItems(List<Product> itemList) : items = List.from(itemList);
  final List<Product> items;
}