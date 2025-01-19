import 'dart:convert';
import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/preferences/app_preferences.dart';
import 'package:app_flutter/shared/data/datasource/shared_preferences_datasource.dart';
import 'package:app_flutter/shared/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasourceImpl implements SharedPreferencesDatasource{

  final SharedPreferences _sharedPreferences;

  SharedPreferencesDatasourceImpl(this._sharedPreferences);

  @override
  Future<bool> saveUserLogged(UserModel user) async{
    try{
      final userJson = jsonEncode(user.toJson());
      bool saved = await _sharedPreferences.setString(AppPreferences.userLogged, userJson);
      return saved;
    }
    catch(e){
      throw SharedPreferencesException(message: "Ocurrió un error al guardar el usuario en preferencias. $e");
    }
  }

  @override
  Future<bool> removeUserLogged() async {
    try{
     bool deleted = await _sharedPreferences.remove(AppPreferences.userLogged);
     return deleted;
    }
    catch(e){
      throw SharedPreferencesException(message: "Ocurrió un error al eliminar el usuario de preferencias. $e");
    }
  }

  @override
  Future<UserModel?> getUserLogged() async{
    try{
      final userJson = _sharedPreferences.getString(AppPreferences.userLogged);
      if (userJson == null) return null;
      return UserModel.fromJson(jsonDecode(userJson));
    }
    catch(e){
      throw SharedPreferencesException(message: "Ocurrió un error al obtener el usuario de preferencias. $e");
    }
  }
}