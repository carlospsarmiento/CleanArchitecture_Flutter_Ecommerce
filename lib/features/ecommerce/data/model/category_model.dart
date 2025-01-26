class CategoryModel {
  String? id;
  String name;
  String description;
  String? image;

  CategoryModel({
    this.id,
    required this.name,
    required this.description,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    name: json["name"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
  };
}

List<CategoryModel> categoryModelListFromJson(List<dynamic> items) => List<CategoryModel>.from(items.map((x) => CategoryModel.fromJson(x)));