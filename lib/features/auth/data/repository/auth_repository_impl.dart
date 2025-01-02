import 'dart:io';
import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:app_flutter/shared/data/datasource/shared_preferences_datasource.dart';
import 'package:app_flutter/shared/data/mappers/user_mapper.dart';
import 'package:app_flutter/shared/data/model/user_model.dart';
import 'package:app_flutter/shared/domain/entity/user.dart';
import 'package:app_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository{

  // Datasources
  final AuthRemoteDataSource _authRemoteDataSource;
  final SharedPreferencesDatasource _sharedPreferencesDatasource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._sharedPreferencesDatasource);

  @override
  Future<Either<Failure, User>> login(String username, String password) async{
    try {
      final userLogged = await _authRemoteDataSource.login(username, password);
      await _sharedPreferencesDatasource.saveUserLogged(userLogged);
      return Right(UserMapper.toEntity(userLogged));
    } on CustomNetworkException catch(e){
      return Left(CustomGenericFailure(message: "No se pudo conectar con el servidor. Verifica tu conexión. ${e.message != null ? "Error: ${e.message}": "" } "));
    } on CustomHttpException catch (e) {
      if(e.statusCode == 401) {
        return Left(CustomGenericFailure(message: "La contraseña es incorrecta"));
      } else {
        return Left(CustomGenericFailure(message: "Error del servidor (${e.statusCode}). Inténtalo más tarde."));
      }
    }
    on CustomApiException catch(e){
      return Left(CustomGenericFailure(message: e.message));
    }
    on SharedPreferencesException catch(e){
      return Left(CustomGenericFailure(message: "Ocurrió un error. ${e.message}"));
    }
    on CustomGenericException catch(e){
      return Left(CustomGenericFailure(message: "Ocurrió un error. ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async{
    try{
      UserModel? userLogged = await _sharedPreferencesDatasource.getUserLogged();
      final loggedAuth = await _authRemoteDataSource.logout(userLogged!.id!);
      await _sharedPreferencesDatasource.removeUserLogged();
      return Right(loggedAuth);
    }
    on CustomHttpException catch (e) {
      return Left(CustomGenericFailure(message: "Error del servidor (${e.statusCode}). Inténtalo más tarde."));
    }
    on CustomApiException catch(e){
      return Left(CustomGenericFailure(message: e.message));
    }
    on CustomGenericException catch(e){
      return Left(CustomGenericFailure(message: "Ocurrió un error. ${e.message}"));
    }
  }

  @override
  Future<Either<Failure, User?>> getUserLogged() async{
    try{
      UserModel? userLogged = await _sharedPreferencesDatasource.getUserLogged();
      User? result = userLogged !=null ? UserMapper.toEntity(userLogged) : null;
      return Right(result);
    }
    on SharedPreferencesException catch (e) {
      return Left(CustomGenericFailure(message: "Ocurrió un error. ${e.message}"));
    }
  }

  @override
  Future<String?> getToken() async{
    UserModel? userLogged = await _sharedPreferencesDatasource.getUserLogged();
    return userLogged?.sessionToken;
  }

  @override
  Future<Either<Failure,User>> signUp(User user, File? image) async{
    try{
      final result = await _authRemoteDataSource.signUp(UserMapper.toModel(user),image);
      return Right(UserMapper.toEntity(result));
    }
    on CustomHttpException catch (e) {
      return Left(CustomGenericFailure(message: "Error del servidor (${e.statusCode}). Inténtalo más tarde."));
    }
    on CustomApiException catch(e){
      return Left(CustomGenericFailure(message: e.message));
    }
    on CustomGenericException catch(e){
      return Left(CustomGenericFailure(message: "Ocurrió un error. ${e.message}"));
    }
  }
}