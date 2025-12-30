class ServiceCard {
  final String title;
  final String subTitle;
  final String iconUrl;

  ServiceCard({
    required this.title,
    required this.subTitle,
    required this.iconUrl,
  });

  factory ServiceCard.fromJson(Map<String, dynamic> json) {
    return ServiceCard(
      title: json['title'] ?? '',
      subTitle: json['text'] ?? '',
      iconUrl: json['icon']?['url'] ?? '',
    );
  }
}