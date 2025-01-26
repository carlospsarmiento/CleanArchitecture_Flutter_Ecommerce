import 'package:app_flutter/shared/domain/entity/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserAvatarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserAvatarLoading extends UserAvatarState {}

class UserAvatarLoaded extends UserAvatarState {
  final User user;
  UserAvatarLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserAvatarFailure extends UserAvatarState {
  final String message;
  UserAvatarFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
