import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:app_flutter/features/auth/domain/entity/user.dart';
import 'package:app_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, User>> login(String username, String password) async{
    try{
      final response = await _authRemoteDataSource.login(username, password);
      return Right(response.toEntity());
    }
    on DioException{
      return Left(ServerFailure());
    }
    catch(ex){
      return Left(LocalFailure());
    }
  }
}