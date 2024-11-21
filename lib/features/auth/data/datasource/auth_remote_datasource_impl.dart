import 'package:app_flutter/core/network/dio_client.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:app_flutter/features/auth/data/model/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<UserModel> login(String username, String password) async{
    final result = await _client.dio.get("/login");
    return UserModel.fromJson(result.data);
  }
}