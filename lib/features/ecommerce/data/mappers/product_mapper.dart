import 'package:app_flutter/features/ecommerce/data/model/product_model.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/product.dart';

class ProductMapper {
  static Product toEntity(ProductModel model) {
    return Product(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      isFeatured: model.isFeatured,
      idCategory: model.idCategory,
      image: model.image,
    );
  }
}