import 'package:app_flutter/features/ecommerce/data/model/special_offer_model.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/special_offer.dart';

class SpecialOfferMapper {
  static SpecialOffer toEntity(SpecialOfferModel model) {
    return SpecialOffer(
      id: model.id,
      title: model.title,
      description: model.description,
      imageUrl: model.imageUrl,
      discountPercentage: model.discountPercentage,
      startDate: model.startDate,
      endDate: model.endDate,
      active: model.active,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static SpecialOfferModel toModel(SpecialOffer entity) {
    return SpecialOfferModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      imageUrl: entity.imageUrl,
      discountPercentage: entity.discountPercentage,
      startDate: entity.startDate,
      endDate: entity.endDate,
      active: entity.active,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
