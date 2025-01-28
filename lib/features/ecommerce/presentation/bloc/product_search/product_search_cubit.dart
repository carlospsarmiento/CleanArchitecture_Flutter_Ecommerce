import 'package:app_flutter/features/ecommerce/domain/usecase/search_products.dart';
import 'package:app_flutter/features/ecommerce/presentation/bloc/product_search/product_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  final SearchProducts _searchProductsUseCase;

  ProductSearchCubit(this._searchProductsUseCase) : super(ProductSearchInitial());

 void searchProducts(String name) async {
    emit(ProductSearchLoading());
    final result = await _searchProductsUseCase(name);
    result.fold(
      (failure) => emit(ProductSearchError(failure.message ?? '')),
      (products) => emit(ProductSearchLoaded(products)),
    );
  }
}