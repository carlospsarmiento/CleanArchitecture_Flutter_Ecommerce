import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  AuthLoginEvent({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class AuthLogoutEvent extends AuthEvent {}
