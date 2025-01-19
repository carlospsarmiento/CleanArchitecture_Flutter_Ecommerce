import 'package:app_flutter/features/ecommerce/domain/entity/category.dart';
import 'package:equatable/equatable.dart';

abstract class CategoriesDisplayState extends Equatable{
  @override
  List<Object?> get props => [];
}

class CategoriesLoading extends CategoriesDisplayState{}

class CategoriesLoaded extends CategoriesDisplayState{
  final List<Category> categories;
  CategoriesLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoriesFailure extends CategoriesDisplayState{
  final String message;
  CategoriesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}