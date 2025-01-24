import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/network/api_endpoints.dart';
import 'package:app_flutter/core/network/api_response.dart';
import 'package:app_flutter/core/network/dio_client.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/special_offer/special_offer_remote_datasource.dart';
import 'package:app_flutter/features/ecommerce/data/model/special_offer_model.dart';

class SpecialOfferRemoteDataSourceImpl implements SpecialOfferRemoteDataSource {
  final DioClient _client;

  SpecialOfferRemoteDataSourceImpl(this._client);

  @override
  Future<List<SpecialOfferModel>> listAll() async {
    try {
      final response = await _client.dio.get(ApiEndpoints.getAllSpecialOffers);
      if (response.statusCode != 200) {
        throw CustomHttpException(statusCode: response.statusCode);
      }
      ApiResponse<List<SpecialOfferModel>> result = ApiResponse.fromJson(
        response.data,
        (responseData) => (responseData as List<dynamic>)
            .map((item) => SpecialOfferModel.fromJson(item))
            .toList(),
      );
      if (result.success && result.data != null) {
        return result.data!;
      } else {
        throw CustomApiException(message: result.message);
      }
    } catch (e) {
      throw CustomGenericException(message: e.toString());
    }
  }
}
