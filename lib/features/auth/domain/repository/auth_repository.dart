import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/auth/domain/entity/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository{
  Future<Either<Failure,User>> login(String username, String password);
}