import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure,List<Product>>> getFeaturedProducts();
  Future<Either<Failure,List<Product>>> searchProducts(String name);
}
