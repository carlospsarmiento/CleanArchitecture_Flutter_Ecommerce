import 'package:app_flutter/shared/domain/entity/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  final User user;

  AuthLoginSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthLoginFailState extends AuthState {
  final String message;

  AuthLoginFailState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthFieldValidationState extends AuthState {
  final String? usernameError;
  final String? passwordError;

  AuthFieldValidationState({this.usernameError, this.passwordError});

  AuthFieldValidationState copyWith({
    String? usernameError,
    String? passwordError
  }){
    return AuthFieldValidationState(
      usernameError: usernameError,
      passwordError: passwordError
    );
  }

  @override
  List<Object?> get props => [usernameError,passwordError];
}