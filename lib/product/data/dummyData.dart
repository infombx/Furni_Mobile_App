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
    required this.display_image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    const String baseUrl = "http://159.65.15.249:1337";

    // 1. EXTRACT CATEGORY NAME
    String categoryName = "General";
    if (json['product_category'] is Map) {
      categoryName = json['product_category']['name']?.toString() ?? "General";
    }

    // 2. PARSE RICH TEXT DESCRIPTION BLOCKS
    String parseDescription(dynamic descData) {
      if (descData is String) return descData;
      if (descData is List) {
        return descData.map((paragraph) {
          if (paragraph is Map && paragraph['children'] is List) {
            return (paragraph['children'] as List)
                .map((child) => (child is Map) ? (child['text']?.toString() ?? '') : '')
                .join('');
          }
          return '';
        }).join('\n');
      }
      return "";
    }

    // 3. IMAGE URL HELPER
    // Handles both full URLs, relative paths, and nesting within objects
    String parseImageUrl(dynamic imageData) {
      if (imageData == null) return 'https://via.placeholder.com/300';
      
      String path = "";
      
      // If it's the Strapi Image Object: { "url": "/uploads/..." }
      if (imageData is Map && imageData.containsKey('url')) {
        path = imageData['url'].toString();
      } else {
        // If it's a direct string link
        path = imageData.toString().trim().replaceAll('\n', '').replaceAll('\r', '');
      }

      if (path.isEmpty) return 'https://via.placeholder.com/300';
      if (path.startsWith('http')) return path;
      
      // Ensure we don't double up on /uploads if it's already in the path
      return path.startsWith('/') ? '$baseUrl$path' : '$baseUrl/$path';
    }

    // 4. FIX FOR COLOUR TEXT
    List<String> extractColours(dynamic data) {
      if (data == null || data is! List) return [];
      return data.map((item) {
        if (item is Map) {
          return item['name']?.toString() ?? "";
        }
        return item.toString();
      }).where((name) => name.isNotEmpty).toList();
    }

    // 5. PREPARE IMAGE LISTS
    List<String> imagesList = [];
    if (json['images'] != null && json['images'] is List && (json['images'] as List).isNotEmpty) {
      imagesList = (json['images'] as List).map((i) => parseImageUrl(i)).toList();
    }

    // 6. SET DISPLAY IMAGE (Featured)
    // Fallback: Use the first image from imagesList if display_image is empty
    String displayImg = '';
    if (json['featuredImageLink'] != null) {
      displayImg = parseImageUrl(json['featuredImageLink']);
    } else if (imagesList.isNotEmpty) {
      displayImg = imagesList.first;
    } else {
      displayImg = 'https://via.placeholder.com/300';
    }

    return Product(
      id: json['id'] ?? 0,
      name: (json['title'] ?? 'Unnamed').toString(),
      category: categoryName,
      description: parseDescription(json['description']),
      measurements: (json['measurement'] ?? '').toString(),
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['stock'] ?? 0,
      rating: json['rating'] ?? 0,
      display_image: displayImg,
      images: imagesList.isEmpty ? [displayImg] : imagesList,
      colours: extractColours(json['colour']),
    );
  }
}
final List<String> category = [
  "Kitchen",
  "Living Room",
  "Bedroom",
  "Bathroom",
  "Outdoor"
];