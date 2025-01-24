class Category{
  String? id;
  String name;
  String description;
  String? image;

  Category({
    this.id,
    required this.name,
    required this.description,
    this.image,
  });
}