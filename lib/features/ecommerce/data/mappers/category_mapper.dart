import 'package:app_flutter/features/ecommerce/data/model/category_model.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/category.dart';

class CategoryMapper{
  static Category toEntity(CategoryModel model) {
    return Category(
      id: model.id,
      name: model.name,
      description: model.description,
    );
  }
}