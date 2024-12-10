import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:app_flutter/shared/domain/entity/user.dart';
import 'package:dartz/dartz.dart';

class GetUserLogged{

  final AuthRepository _repository;

  GetUserLogged(this._repository);

  Future<Either<Failure,User?>> call(){
    return _repository.getUserLogged();
  }
}