import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/category/category_remote_datasource.dart';
import 'package:app_flutter/features/ecommerce/data/mappers/category_mapper.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/category.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository{

  final CategoryRemoteDatasource _categoryRemoteDatasource;

  CategoryRepositoryImpl(this._categoryRemoteDatasource);

  @override
  Future<Either<Failure, List<Category>>> getAll() async{
    try{
      final result = await _categoryRemoteDatasource.getAll();
      return Right(result.map((e) => CategoryMapper.toEntity(e)).toList());
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