class CategoryModel {
  final int id;
  final String name;
  final String? slug;

  CategoryModel({required this.id, required this.name, this.slug});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name']?.toString() ?? 'Unknown',
      slug: json['slug'],
    );
  }
}
