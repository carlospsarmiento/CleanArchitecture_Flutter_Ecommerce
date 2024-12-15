import 'dart:io';
import 'package:app_flutter/core/errors/failure.dart';
import 'package:app_flutter/features/auth/domain/usecase/login_user.dart';
import 'package:app_flutter/features/auth/domain/usecase/get_userlogged.dart';
import 'package:app_flutter/features/auth/domain/usecase/logout_user.dart';
import 'package:app_flutter/features/auth/domain/usecase/signup_user.dart';
import 'package:app_flutter/shared/domain/entity/user.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{

  // UseCases
  final LoginUser _loginUser;
  final LogoutUser _logoutUser;
  final GetUserLogged _getUserLogged;
  final SignupUser _signupUser;

  // Variables
  //String? usernameError;
  //String? passwordError;

  AuthCubit(
      this._loginUser,
      this._logoutUser,
      this._getUserLogged,
      this._signupUser
      ):super(AuthInitialState());

  Future<void> signUp(User user, File? image) async{
    emit(AuthSignupLoadingState());
    final result = await _signupUser.call(user, image);
    result.fold(
      (failure){
        String errorMessage = "Ocurrió un error en el registro.";
        if (failure is NetworkFailure) {
          errorMessage = failure.message ?? "No se pudo conectar al servidor.";
        } else if (failure is HttpFailure) {
          errorMessage = failure.message ?? "Error del servidor. Inténtalo más tarde.";
        } else if (failure is ParseFailure) {
          errorMessage = failure.message ?? "Error al procesar los datos.";
        } else if (failure is UnexpectedFailure) {
          errorMessage = failure.message ?? "Ocurrió un error inesperado.";
        }
        emit(AuthSignupFailState(message: errorMessage));
      },
      (user){
        emit(AuthSignupSuccessState(user: user));
      });
  }

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
        emit(AuthLoginSuccessState(user: user));
      },
    );
  }

  Future<void> logout() async{
    emit(AuthLogoutLoadingState());
    final result = await _logoutUser.call();
    result.fold(
      (failure){
        emit(AuthLogoutFailState(message: failure.message!));
    },(loggedOut) async{
        emit(AuthLogoutSuccessState(loggedOut: loggedOut));
    });
  }

  Future<void> checkUserLogged() async{
    emit(AuthCheckUserLoggedLoadingState());
    final result = await _getUserLogged.call();
    result.fold(
      (failure){
        emit(AuthCheckUserLoggedFailState(message: failure.message!));
      },
      (user){
        emit(AuthCheckUserLoggedSuccessState(userLogged: user));
      }
    );
  }

  /*
  void validateUsername(String? username) {
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
  */
}