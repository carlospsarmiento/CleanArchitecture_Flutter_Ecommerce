import 'package:app_flutter/features/ecommerce/domain/entity/product.dart';
import 'package:equatable/equatable.dart';

abstract class FeaturedProductsState extends Equatable{
    const FeaturedProductsState();

  @override
  List<Object?> get props => [];
}

class FeaturedProductsInitial extends FeaturedProductsState {}

class FeaturedProductsLoading extends FeaturedProductsState {}

class FeaturedProductsLoaded extends FeaturedProductsState {
  final List<Product> products;

  const FeaturedProductsLoaded(this.products);

    @override
  List<Object?> get props => [products];
}

class FeaturedProductsError extends FeaturedProductsState {
  final String message;

  const FeaturedProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
