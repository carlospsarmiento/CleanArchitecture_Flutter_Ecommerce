import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/special_offer/special_offer_remote_datasource.dart';
import 'package:app_flutter/features/ecommerce/data/mappers/special_offer_mapper.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/special_offer.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/special_offer_repository.dart';
import 'package:dartz/dartz.dart';

class SpecialOfferRepositoryImpl implements SpecialOfferRepository {
  final SpecialOfferRemoteDataSource _remoteDataSource;

  SpecialOfferRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<SpecialOffer>>> getAll() async {
    try {
      final result = await _remoteDataSource.getAll();
      return Right(result.map((e) => SpecialOfferMapper.toEntity(e)).toList());
    } on CustomHttpException catch (e) {
      return Left(CustomGenericFailure(
          message: "Error del servidor (${e.statusCode}). Inténtalo más tarde."));
    } on CustomApiException catch (e) {
      return Left(CustomGenericFailure(message: e.message));
    } on CustomGenericException catch (e) {
      return Left(CustomGenericFailure(message: "Ocurrió un error. ${e.message}"));
    }
  }
}