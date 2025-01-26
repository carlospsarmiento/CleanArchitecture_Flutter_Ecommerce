import 'package:app_flutter/features/ecommerce/data/model/special_offer_model.dart';

abstract class SpecialOfferRemoteDataSource {
  Future<List<SpecialOfferModel>> getAll();
}
