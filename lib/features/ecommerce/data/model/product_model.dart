class ProductModel {
  final String id;
  final String name;
  final String description;
  final String price;
  final bool isFeatured;
  final String idCategory;
  final String? image;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isFeatured,
    required this.idCategory,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] is int ? json["id"].toString() : json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      isFeatured: json['is_featured'] ?? false,
      idCategory: json['id_category'].toString(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'is_featured': isFeatured,
    'id_category': idCategory,
    'image': image,
  };
}
