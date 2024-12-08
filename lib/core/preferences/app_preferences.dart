import 'dart:convert';

import 'package:app_flutter/shared/domain/entity/user.dart';
import 'package:app_flutter/shared/domain/mappers/user_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{

  static const _keyUser = 'user';
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> saveUserLogged(User user) async {
    final userJson = jsonEncode(UserMapper.toJson(user));
    await _sharedPreferences.setString(_keyUser, userJson);
  }

  User? getUserLogged() {
    final userJson = _sharedPreferences.getString(_keyUser);
    if (userJson == null) return null;
    return UserMapper.fromJson(jsonDecode(userJson));
  }

  Future<void> clearUser() async {
    await _sharedPreferences.remove(_keyUser);
  }
}