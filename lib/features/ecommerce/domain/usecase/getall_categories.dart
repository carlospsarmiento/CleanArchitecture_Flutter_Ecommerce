import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/category.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCategories{
  final CategoryRepository _repository;

  GetAllCategories(this._repository);

  Future<Either<Failure,List<Category>>> call(){
    return _repository.listAll();
  }
}