import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/network/api_endpoints.dart';
import 'package:app_flutter/core/network/api_response.dart';
import 'package:app_flutter/core/network/dio_client.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/category/category_remote_datasource.dart';
import 'package:app_flutter/features/ecommerce/data/model/category_model.dart';

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource{

  final DioClient _client;

  CategoryRemoteDatasourceImpl(this._client);

  @override
  Future<List<CategoryModel>> listAll() async{
    try{
      final response = await _client.dio.get(ApiEndpoints.getAllCategories);
      if (response.statusCode != 200) {
        throw CustomHttpException(statusCode: response.statusCode);
      }
      ApiResponse<List<CategoryModel>> result = ApiResponse.fromJson(
        response.data, (responseData){
          return categoryModelListFromJson(responseData);
        }
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