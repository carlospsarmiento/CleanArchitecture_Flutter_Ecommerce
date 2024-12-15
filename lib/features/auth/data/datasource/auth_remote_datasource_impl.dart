import 'dart:convert';
import 'dart:io';

import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/network/api_endpoints.dart';
import 'package:app_flutter/core/network/api_response.dart';
import 'package:app_flutter/core/network/dio_client.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:app_flutter/shared/data/model/user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  Future<UserModel> login(String username, String password) async {
    try {
      final data = {
        'email': username,
        'password': password,
      };
      final response = await _client.dio.post(ApiEndpoints.login,data: data);
      if (response.statusCode != 200) {
        throw HttpException(statusCode: response.statusCode);
      }
      ApiResponse<UserModel> result = ApiResponse.fromJson(
          response.data, (responseData){
            return UserModel.fromJson(responseData);
          }
      );
      if (result.success && result.data != null) {
        return result.data!;
      } else {
        throw ApiException(message: result.message);
      }

    } on DioException catch(e){
      throw NetworkException(message: e.message); // Error de red
    } on HttpException{
      rethrow;
    } on ApiException{
      rethrow;
    }
    catch (error) {
      throw ParseException(); // Error de parsing u otros errores
    }
  }

  @override
  Future<bool> logout(String id) async{
    try{
      final data = {'id': id};
      final response = await _client.dio.post(ApiEndpoints.logout,data: data);
      if (response.statusCode != 200) {
        throw HttpException(statusCode: response.statusCode);
      }
      ApiResponse<UserModel> result = ApiResponse.fromJson(
          response.data, (responseData){
        return UserModel.fromJson(responseData);
      });
      if (result.success) {
        return result.success;
      } else {
        throw ApiException(message: result.message);
      }
    }
    on HttpException{
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp(UserModel user, File? image) async{
    try{
      final formData = FormData.fromMap({
        'user': jsonEncode(user.toJson()),
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.uri.pathSegments.last, // Para extraer el nombre del archivo
          ),
      });
      final response = await _client.dio.post(ApiEndpoints.signup,data: formData);
      if (response.statusCode != 201) {
        throw HttpException(statusCode: response.statusCode);
      }
      ApiResponse<UserModel> result = ApiResponse.fromJson(
          response.data, (responseData){
        return UserModel.fromJson(responseData);
      }
      );
      if (result.success && result.data != null) {
        return result.data!;
      } else {
        throw ApiException(message: result.message);
      }
    }
    on HttpException{
      rethrow;
    }
    catch (error) {
      throw ParseException(); // Error de parsing u otros errores
    }
  }
}