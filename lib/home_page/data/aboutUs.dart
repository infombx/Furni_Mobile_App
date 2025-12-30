class AboutData {
  final String heading;
  final String description;
  final String imageUrl;
  final String ctaText;

  AboutData({
    required this.heading,
    required this.description,
    required this.imageUrl,
    required this.ctaText,
  });

  factory AboutData.fromJson(Map<String, dynamic> json) {
    // Extracting text from Strapi's rich text array structure
    String desc = "";
    if (json['content'] != null && json['content'].isNotEmpty) {
      desc = json['content'][0]['children'][0]['text'] ?? "";
    }

    return AboutData(
      heading: json['heading'] ?? "",
      description: desc,
      imageUrl: json['image']?['url'] ?? "",
      ctaText: json['cta']?['text'] ?? "Contact Us",
    );
  }
}