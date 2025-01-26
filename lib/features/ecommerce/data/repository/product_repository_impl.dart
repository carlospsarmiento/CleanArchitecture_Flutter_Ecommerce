import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/product/product_remote_datasource.dart';
import 'package:app_flutter/features/ecommerce/data/mappers/product_mapper.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/product.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource _productRemoteDatasource;

  ProductRepositoryImpl(this._productRemoteDatasource);

 @override
  Future<Either<Failure, List<Product>>> getFeaturedProducts() async {
    try{
      final result = await _productRemoteDatasource.getFeaturedProducts();
      return Right(result.map((e) => ProductMapper.toEntity(e)).toList());
    }
    on CustomHttpException catch (e) {
      return Left(CustomGenericFailure(message: "Error del servidor (${e.statusCode}). Inténtalo más tarde."));
    }
    on CustomApiException catch(e){
      return Left(CustomGenericFailure(message: e.message));
    }
    on CustomGenericException catch(e){
      return Left(CustomGenericFailure(message: "Ocurrió un error. ${e.message}"));
    }
  }
}
