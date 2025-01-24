import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/special_offer.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/special_offer_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllSpecialOffers {
  final SpecialOfferRepository _repository;

  GetAllSpecialOffers(this._repository);

  Future<Either<Failure, List<SpecialOffer>>> call() {
    return _repository.getAll();
  }
}
