import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/network/api_endpoints.dart';
import 'package:app_flutter/core/network/api_response.dart';
import 'package:app_flutter/core/network/dio_client.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/product/product_remote_datasource.dart';
import 'package:app_flutter/features/ecommerce/data/model/product_model.dart';

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  
  final DioClient _client;

  ProductRemoteDatasourceImpl(this._client);

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try{
      final response = await _client.dio.get(ApiEndpoints.getFeaturedProducts);
      if (response.statusCode != 200) {
        throw CustomHttpException(statusCode: response.statusCode);
      }
      ApiResponse<List<ProductModel>> result = ApiResponse.fromJson(
        response.data,
        (responseData) => (responseData as List<dynamic>)
            .map((item) => ProductModel.fromJson(item))
            .toList(),
      );
      if (result.success && result.data != null) {
        return result.data!;
      } else {
        throw CustomApiException(message: result.message);
      }
    }
    catch(e){
      throw CustomGenericException(message: e.toString());
    }
  }
  
  @override
  Future<List<ProductModel>> searchProducts(String name) async {
    try{
      final response = await _client.dio.get(ApiEndpoints.searchProducts(name));
      if (response.statusCode != 200) {
        throw CustomHttpException(statusCode: response.statusCode);
      }
      ApiResponse<List<ProductModel>> result = ApiResponse.fromJson(
        response.data,
        (responseData) => (responseData as List<dynamic>)
            .map((item) => ProductModel.fromJson(item))
            .toList(),
      );
      if (result.success && result.data != null) {
        return result.data!;
      } else {
        throw CustomApiException(message: result.message);
      }
    }
    catch(e){
      throw CustomGenericException(message: e.toString());
    }
  }
}
