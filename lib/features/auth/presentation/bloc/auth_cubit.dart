import 'package:app_flutter/features/auth/domain/usecase/login_user.dart';
import 'package:app_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{

  final LoginUser _loginUser;

  AuthCubit(this._loginUser):super(AuthInitialState());

  Future<void> login(String username, String password) async{
    emit(AuthLoginLoadingState());
    final result = await _loginUser.call(username, password);
    result.fold((l){
      emit(AuthLoginFailState(message: "Ocurrió un error en el login"));
    }, (r){
      emit(AuthLoginSuccessState(user: r));
    });
  }
}