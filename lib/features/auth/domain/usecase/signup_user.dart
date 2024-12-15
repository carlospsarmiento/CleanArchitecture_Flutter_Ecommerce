import 'dart:io';
import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/shared/domain/entity/user.dart';
import 'package:app_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignupUser{

  final AuthRepository _repository;

  SignupUser(this._repository);

  Future<Either<Failure,User>> call(User user, File? image){
    return _repository.signUp(user, image);
  }
}