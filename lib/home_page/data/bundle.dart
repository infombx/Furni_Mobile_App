class BundleModel {
  final int id;
  final String title;
  final String imageUrl;
  final String ctaText;
  final String href;

  BundleModel({
    required this.id, 
    required this.title, 
    required this.imageUrl, 
    required this.ctaText,
    required this.href,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) {
    // Navigate to the image URL
    final String imgPath = json['image']?['url'] ?? "";
    
    // Navigate to the CTA component
    final String btnText = json['cta']?['text'] ?? "Shop Now";
    final String link = json['cta']?['href'] ?? "";

    return BundleModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Untitled',
      imageUrl: imgPath,
      ctaText: btnText,
      href: link,
    );
  }
}