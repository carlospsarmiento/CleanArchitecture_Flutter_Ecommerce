import 'dart:convert';

class CategoryModel {
  String? id;
  String name;
  String description;

  CategoryModel({
    this.id,
    required this.name,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}

List<CategoryModel> categoryModelListFromJson(List<dynamic> items) => List<CategoryModel>.from(items.map((x) => CategoryModel.fromJson(x)));
//List<CategoryModel> categoryModelListFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));