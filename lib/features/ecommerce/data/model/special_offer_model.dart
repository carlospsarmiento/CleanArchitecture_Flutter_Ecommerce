class SpecialOfferModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int discountPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;

  SpecialOfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SpecialOfferModel.fromJson(Map<String, dynamic> json) {
    return SpecialOfferModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      discountPercentage: json['discount_percentage'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      active: json['active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'discount_percentage': discountPercentage,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'active': active,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
