import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/product.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetFeaturedProducts {
  final ProductRepository _repository;

  GetFeaturedProducts(this._repository);

  Future<Either<Failure, List<Product>>> call(){
    return _repository.getFeaturedProducts();
  }
}