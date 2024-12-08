import 'package:app_flutter/shared/domain/entity/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

// INITIAL STATE
class AuthInitialState extends AuthState {}


// LOGIN USER
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

// CHECK USER LOGGED
class AuthCheckUserLoggedLoadingState extends AuthState {}

class AuthCheckUserLoggedSuccessState extends AuthState {}

class AuthCheckUserLoggedFailState extends AuthState {}

// LOGOUT USER
class AuthLogoutLoadingState extends AuthState {}

class AuthLogoutSuccessState extends AuthState {
  final bool loggedOut;

  AuthLogoutSuccessState({required this.loggedOut});

  @override
  List<Object> get props => [loggedOut];
}

class AuthLogoutFailState extends AuthState {
  final String message;

  AuthLogoutFailState({required this.message});

  @override
  List<Object?> get props => [message];
}


