class Category {
  final String? id;
  final String name;
  final String description;
  final String? image;

  Category({
    this.id,
    required this.name,
    required this.description,
    this.image,
  });
}