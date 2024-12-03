import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/network/api_endpoints.dart';
import 'package:app_flutter/core/network/dio_client.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:app_flutter/features/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  /*
  @override
  Future<UserModel> login(String username, String password) async{
    final result = await _client.dio.get(ApiEndpoints.getAllUsers);
    return UserModel.fromJson(result.data);
  }
  */

  Future<UserModel> login(String username, String password) async {
    try {
      final data = {
        'email': username,
        'password': password,
      };

      final response = await _client.dio.post(ApiEndpoints.login,data: data);

      // Validamos el código de estado
      if (response.statusCode != 200) {
        throw HttpException(statusCode: response.statusCode);
      }

      // Convertimos el JSON a UserModel
      return UserModel.fromJson(response.data);
    } on DioException catch(e){
      throw NetworkException(); // Error de red
    } on HttpException catch (e) {
      // Este bloque captura la HttpException lanzada previamente
      rethrow;  // Re-lanzamos la misma excepción si ya fue lanzada
    } catch (error) {
      throw ParseException(); // Error de parsing u otros errores
    }
  }

}