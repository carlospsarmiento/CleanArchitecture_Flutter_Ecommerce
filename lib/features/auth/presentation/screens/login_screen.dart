import 'package:app_flutter/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_progress_dialog.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: BlocListener<AuthCubit,AuthState>(
          listener: (context, state) => _listenAuthCubit(context,state),
          child: SafeArea(
            child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.1),
                        _widgetLogo(),
                        SizedBox(height: screenHeight * 0.1),
                        _widgetTitle(context),
                        SizedBox(height: screenHeight * 0.05),
                        _widgetForm(context)
                      ],
                    ),
                  ),
                )
            ),
        ),
    );
  }

  void _listenAuthCubit(BuildContext context, AuthState state){
    if(state is AuthLoginLoadingState){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomProgressDialog(message: "Iniciando sesión...")
      );
    }

    if (state is AuthLoginSuccessState) {
      Navigator.of(context).pop();
      // Realiza las acciones necesarias en el caso de éxito
    }

    if (state is AuthLoginFailState) {
      Navigator.of(context).pop();
      CustomSnackBar.show(context, message: state.message);
    }
  }

  Widget _widgetLogo(){
    return SvgPicture.asset(
      "assets/svg/img_login.svg",
      height: 170
    );
  }

  Widget _widgetTitle(BuildContext context){
    return Text(
        "Login",
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
         fontWeight: FontWeight.bold
        ),
    );
  }

  Widget _widgetForm(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _widgetTextFieldUsername(context),
          const SizedBox(height: 16.0),
          _widgetTextFieldPassword(context),
          const SizedBox(height: 16.0),
          _widgetButtonSignIn(context),
          const SizedBox(height: 16.0),
          _widgetTextButtonForgotPassword(context),
          _widgetTextButtonSignUp(context)
        ],
      ),
    );
  }

  Widget _widgetTextFieldUsername(BuildContext context){
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Usuario",
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary
            )
        ),
      ),
      onSaved: (username) {
      },
    );
  }

  Widget _widgetTextFieldPassword(BuildContext context){
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Contraseña",
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary
            )
        ),
      ),
      onSaved: (username) {
      },
    );
  }

  Widget _widgetButtonSignIn(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width ,
      child: FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              // usamos el cubit para iniciar sesion
              context.read<AuthCubit>().login("abc", "123");
            }
          },
          child: Text("Ingresar")
      ),
    );
  }

  Widget _widgetTextButtonForgotPassword(BuildContext context){
    return TextButton(
        onPressed: (){},
        child: Text(
          "¿Olvidaste tu contraseña?",
          style: Theme.of(context)
                .textTheme
                .bodyMedium!
              .copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .color!
                      .withOpacity(0.6)
              )
        )
    );
  }

  Widget _widgetTextButtonSignUp(BuildContext context){
    return TextButton(
      onPressed: () {},
      child: Text.rich(
         TextSpan(
          text: "¿No tienes una cuenta? ",
          children: [
            TextSpan(
              text: "Registrate",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(
          color: Theme.of(context)
              .textTheme
              .bodyMedium!
              .color!
              .withOpacity(0.6)
        ),
      ),
    );
  }
}
