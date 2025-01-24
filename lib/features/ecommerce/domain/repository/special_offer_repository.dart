import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/special_offer.dart';
import 'package:dartz/dartz.dart';

abstract class SpecialOfferRepository {
  Future<Either<Failure, List<SpecialOffer>>> getAll();
}
