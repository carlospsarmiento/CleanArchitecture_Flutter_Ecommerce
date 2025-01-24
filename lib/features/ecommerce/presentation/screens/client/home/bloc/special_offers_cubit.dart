import 'package:app_flutter/features/ecommerce/domain/entity/special_offer.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/get_all_special_offers.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/special_offers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialOffersCubit extends Cubit<SpecialOffersState> {
  final GetAllSpecialOffers _getAllSpecialOffers;

  SpecialOffersCubit(this._getAllSpecialOffers) : super(SpecialOffersInitialState());

  Future<void> getAllSpecialOffers() async {
    emit(SpecialOffersLoadingState());
    final result = await _getAllSpecialOffers();
    result.fold(
      (failure) => emit(SpecialOffersErrorState(failure.message?? "")),
      (offers) => emit(SpecialOffersLoadedState(offers)),
    );
  }
}
