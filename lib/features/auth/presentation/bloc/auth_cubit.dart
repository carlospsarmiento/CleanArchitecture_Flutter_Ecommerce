import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/core/preferences/app_preferences.dart';
import 'package:app_flutter/core/utils/validators.dart';
import 'package:app_flutter/features/auth/domain/usecase/login_user.dart';
import 'package:app_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{

  // UseCases
  final LoginUser _loginUser;

  // Preferences
  final AppPreferences _appPreferences;

  // Variables
  String? usernameError;
  String? passwordError;

  AuthCubit(this._loginUser, this._appPreferences):super(AuthInitialState());

  Future<void> login(String username, String password) async{
    emit(AuthLoginLoadingState());
    final result = await _loginUser.call(username, password);
    result.fold(
      (failure) {
        String errorMessage = "Ocurrió un error en el login.";

        if (failure is NetworkFailure) {
          errorMessage = failure.message ?? "No se pudo conectar al servidor.";
        } else if (failure is HttpFailure) {
          errorMessage = failure.message ?? "Error del servidor. Inténtalo más tarde.";
        } else if (failure is ParseFailure) {
          errorMessage = failure.message ?? "Error al procesar los datos.";
        } else if (failure is UnexpectedFailure) {
          errorMessage = failure.message ?? "Ocurrió un error inesperado.";
        }
        emit(AuthLoginFailState(message: errorMessage));
      },
      (user) async {
        await _appPreferences.saveUser(user);
        emit(AuthLoginSuccessState(user: user));
      },
    );
  }

  Future<void> checkUserLogged() async{

  }

  void validateUsername(String? username) {
    /*
    if (username == null || username.isEmpty) {
      usernameError = 'El usuario no puede estar vacío';
    } else {
      usernameError = null;
    }
    */
    usernameError = Validators.validateEmail(username);
    if(state is AuthFieldValidationState){
        final currentState = state as AuthFieldValidationState;
        emit(currentState.copyWith(usernameError: usernameError));
    }
    else{
      emit(AuthFieldValidationState(
          usernameError: usernameError,
          passwordError: passwordError));
    }
  }

  void validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      passwordError = 'La contraseña no puede estar vacía';
    } else {
      passwordError = null;
    }
    if(state is AuthFieldValidationState){
      final currentState = state as AuthFieldValidationState;
      emit(currentState.copyWith(passwordError: passwordError));
    }
    else{
      emit(AuthFieldValidationState(
          usernameError: usernameError,
          passwordError: passwordError));
    }
  }
}