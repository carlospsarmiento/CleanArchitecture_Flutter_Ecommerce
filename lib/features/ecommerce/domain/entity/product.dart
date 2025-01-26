class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final bool isFeatured;
  final String idCategory;
  final String? image;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isFeatured,
    required this.idCategory,
    this.image,
  });
}
