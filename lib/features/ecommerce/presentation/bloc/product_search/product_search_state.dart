import 'package:app_flutter/features/ecommerce/domain/entity/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductSearchInitial extends ProductSearchState {}

class ProductSearchLoading extends ProductSearchState {}

class ProductSearchLoaded extends ProductSearchState {
  final List<Product> products;

  ProductSearchLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductSearchError extends ProductSearchState {
  final String message;

 ProductSearchError(this.message);


  @override
  List<Object> get props => [message];
}
