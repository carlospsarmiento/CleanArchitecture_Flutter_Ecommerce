class SpecialOffer {
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

  SpecialOffer({
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
}
