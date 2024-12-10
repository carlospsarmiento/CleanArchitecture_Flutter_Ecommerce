import 'package:app_flutter/shared/data/model/user_model.dart';

abstract class SharedPreferencesDatasource{
  Future<bool> saveUserLogged(UserModel user);
  Future<bool> removeUserLogged();
  Future<UserModel?> getUserLogged();
}