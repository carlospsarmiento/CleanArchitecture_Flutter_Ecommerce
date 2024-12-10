import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUser{

  final AuthRepository _repository;

  LogoutUser(this._repository);

  Future<Either<Failure,bool>> call(){
    return _repository.logout();
  }
}