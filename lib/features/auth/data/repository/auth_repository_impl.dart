import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:app_flutter/shared/data/datasource/shared_preferences_datasource.dart';
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
      final user = await _authRemoteDataSource.login(username, password);
      await _sharedPreferencesDatasource.saveUserLogged(user);
      return Right(user.toEntity());
    } on NetworkException catch(e){
      return Left(NetworkFailure(message: "No se pudo conectar con el servidor. Verifica tu conexión. ${e.message != null ? "Error: ${e.message}": "" } "));
    } on HttpException catch (e) {
      if(e.statusCode == 401) {
        return Left(HttpFailure(message: "La contraseña es incorrecta"));
      } else {
        return Left(HttpFailure(message: "Error del servidor (${e.statusCode}). Inténtalo más tarde."));
      }
    }
    on ApiException catch(e){
      return Left(ApiFailure(message: e.message));
    }
    on ParseException {
      return Left(ParseFailure(message: "Ocurrió un error al procesar la respuesta del servidor."));
    }
    on SharedPreferencesException catch(e){
      return Left(SharedPreferencesFailure(message: e.message));
    }
    catch (e) {
      return Left(UnexpectedFailure(message: "Ocurrió un error inesperado."));
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
    on HttpException catch (e) {
      return Left(HttpFailure(message: "Error del servidor (${e.statusCode}). Inténtalo más tarde."));
    }
    on ApiException catch(e){
      return Left(ApiFailure(message: e.message));
    }
    catch (e) {
      return Left(UnexpectedFailure(message: "Ocurrió un error inesperado."));
    }
  }

  @override
  Future<Either<Failure, User?>> getUserLogged() async{
    try{
      UserModel? userLogged = await _sharedPreferencesDatasource.getUserLogged();
      User? result = userLogged?.toEntity();
      return Right(result);
    }
    on SharedPreferencesException catch (e) {
      return Left(SharedPreferencesFailure(message: e.message));
    }
    catch (e) {
      return Left(UnexpectedFailure(message: "Ocurrió un error inesperado."));
    }
  }
}