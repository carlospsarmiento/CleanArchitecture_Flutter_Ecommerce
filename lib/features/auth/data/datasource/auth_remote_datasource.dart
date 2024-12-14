import 'dart:io';

import 'package:app_flutter/shared/data/model/user_model.dart';

abstract class AuthRemoteDataSource{
  Future<UserModel> login(String username, String password);
  Future<bool> logout(String id);
  Future<UserModel> signUp(UserModel user, File file);
}