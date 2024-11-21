import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/auth/domain/entity/user.dart';
import 'package:app_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUser{

  final AuthRepository _repository;

  LoginUser(this._repository);

  Future<Either<Failure,User>> call(String username, String password){
    return _repository.login(username, password);
  }
}