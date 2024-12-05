import 'package:app_flutter/core/errors/exception.dart';
import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:app_flutter/features/auth/domain/entity/user.dart';
import 'package:app_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, User>> login(String username, String password) async{
    try {
      final user = await _authRemoteDataSource.login(username, password);
      return Right(user.toEntity());
    } on NetworkException {
      return Left(NetworkFailure(message: "No se pudo conectar con el servidor. Verifica tu conexión."));
    } on HttpException catch (e) {
      if(e.statusCode == 401) {
        return Left(HttpFailure(message: "La contraseña es incorrecta"));
      } else {
        return Left(HttpFailure(message: "Error del servidor (${e.statusCode}). Inténtalo más tarde."));
      }
    } on ParseException {
      return Left(ParseFailure(message: "Ocurrió un error al procesar la respuesta del servidor."));
    } catch (error) {
      return Left(UnexpectedFailure(message: "Ocurrió un error inesperado."));
    }

  }
}