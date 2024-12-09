import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_state.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_progress_dialog.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_separator.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                        CustomSeparator(height: screenHeight * 0.1),
                        _widgetLogo(),
                        CustomSeparator(height: screenHeight * 0.1),
                        _widgetTitle(context),
                        //SizedBox(height: screenHeight * 0.05),
                        CustomSeparator(height: screenHeight * 0.1),
                        _builderForm()
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
      Navigator.pushNamedAndRemoveUntil(context, 'ecommerce/catalog/list', (route) => false);
    }

    if (state is AuthLoginFailState) {
      Navigator.of(context).pop();
      CustomSnackBar.show(context, message: state.message);
    }
  }

  Widget _builderForm(){
    return BlocBuilder<AuthCubit,AuthState>(
        builder: (context, authState){
          return _widgetForm(context);
        }
    );
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
          CustomSeparator(height: 16),
          _widgetTextFieldPassword(context),
          CustomSeparator(height: 16),
          _widgetButtonSignIn(context),
          CustomSeparator(height: 16),
          _widgetTextButtonForgotPassword(context),
          _widgetTextButtonSignUp(context)
        ],
      ),
    );
  }

  Widget _widgetTextFieldUsername(BuildContext context){
    final authCubit = context.read<AuthCubit>();
    return TextFormField(
      controller: usernameController,
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
        //errorText: authCubit.usernameError
        //  errorText: authState is AuthLoginValidationFailState ? authState.usernameError : null,
      ),
      //onChanged: (value){
      //  authCubit.validateUsername(value);
      //},
      //onSaved: (username) {
      //},

      /*
      onChanged: (value) => authCubit.validateUsername(value),
      validator: (value) {
        authCubit.validateUsername(value);
        return authCubit.usernameError;
      },
      */
    );
  }

  Widget _widgetTextFieldPassword(BuildContext context){
    final authCubit = context.read<AuthCubit>();
    return TextFormField(
      controller: passwordController,
      obscureText: true,
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
        //errorText: authCubit.passwordError
      ),
      /*
      onChanged: (value) => authCubit.validatePassword(value),
      validator: (value){
        authCubit.validatePassword(value);
        return authCubit.passwordError;
      },
      */
    );
  }

  Widget _widgetButtonSignIn(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width ,
      child: FilledButton(
          onPressed: () {
            //if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();
              context.read<AuthCubit>().login(usernameController.text, passwordController.text);
            //}
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
