import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository{
  Future<Either<Failure,List<Category>>> getAll();
}