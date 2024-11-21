import 'package:app_flutter/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource{
  Future<UserModel> login(String username, String password);
}