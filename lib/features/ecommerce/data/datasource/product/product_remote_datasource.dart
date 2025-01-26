import 'package:app_flutter/features/ecommerce/data/model/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getFeaturedProducts();
}