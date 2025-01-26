import 'package:app_flutter/features/auth/domain/usecase/get_userlogged.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/user_avatar/user_avatar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAvatarCubit extends Cubit<UserAvatarState> {
  final GetUserLogged _getUserLogged;

  UserAvatarCubit(this._getUserLogged) : super(UserAvatarLoading());

  void loadUserAvatar() async {
    try {
      final result = await _getUserLogged.call();
      result.fold(
        (failure) => emit(UserAvatarFailure(message: failure.message!)),
        (user) => emit(UserAvatarLoaded(user: user!)),
      );
    } catch (e) {
      emit(UserAvatarFailure(message: e.toString()));
    }
  }
}
