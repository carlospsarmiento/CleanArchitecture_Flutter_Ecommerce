import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/usecase/get_featured_products.dart';
import 'featured_products_state.dart';

class FeaturedProductsCubit extends Cubit<FeaturedProductsState> {
  final GetFeaturedProducts _getFeaturedProducts;

  FeaturedProductsCubit(this._getFeaturedProducts): super(FeaturedProductsInitial());

  Future<void> getFeaturedProducts() async {
    emit(FeaturedProductsLoading());
    final result = await _getFeaturedProducts();
    result.fold(
      (failure) => emit(FeaturedProductsError(failure.message ?? '')),
      (offers) => emit(FeaturedProductsLoaded(offers)),
    );
  }
}
