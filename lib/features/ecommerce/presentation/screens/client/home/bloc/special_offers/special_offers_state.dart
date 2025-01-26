import 'package:app_flutter/features/ecommerce/domain/entity/special_offer.dart';
import 'package:equatable/equatable.dart';

abstract class SpecialOffersState extends Equatable {
  const SpecialOffersState();

  @override
  List<Object?> get props => [];
}

class SpecialOffersInitialState extends SpecialOffersState {}

class SpecialOffersLoadingState extends SpecialOffersState {}

class SpecialOffersLoadedState extends SpecialOffersState {
  final List<SpecialOffer> offers;

  const SpecialOffersLoadedState(this.offers);

  @override
  List<Object?> get props => [offers];
}

class SpecialOffersErrorState extends SpecialOffersState {
  final String message;

  const SpecialOffersErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
