class HeroBannerSection {
  final int id;
  final String headline;
  final String subtext;
  final String image; 

  HeroBannerSection({
    required this.id,
    required this.headline,
    required this.subtext,
    required this.image
  });

  factory HeroBannerSection.fromJson(Map<String, dynamic> json) {
    String url = "";
    
    // Strapi media fields are objects containing a 'url' string
    if (json['SliderImage'] != null && json['SliderImage']['url'] != null) {
      url = json['SliderImage']['url'];
    }

    return HeroBannerSection(
      id: json['id'] ?? 0,
      headline: json['SliderHeadline'] ?? '',
      subtext: json['SliderText'] ?? '', 
      image: url,
    );
  }
}