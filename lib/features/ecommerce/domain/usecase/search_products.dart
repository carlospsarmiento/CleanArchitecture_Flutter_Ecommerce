import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/product.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

class SearchProducts {
  final ProductRepository _productRepository;

  SearchProducts(this._productRepository);

  Future<Either<Failure, List<Product>>> call(String name) async {
    return await _productRepository.searchProducts(name);
  }
}