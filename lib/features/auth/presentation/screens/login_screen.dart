import 'package:app_flutter/core/routes/app_routes.dart';
import 'package:app_flutter/features/auth/presentation/widgets/login_banner.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_state.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_progress_dialog.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_separator.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_snackbar.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_textformfield.dart';
import 'package:app_flutter/shared/utils/responsive_utils.dart';
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
                  //padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        //CustomSeparator(height: screenHeight * 0.1),
                        //_widgetLogo(),
                        ResponsiveUtils.isSmallScreen(context)? const SizedBox() : Expanded(child: LoginBanner()),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  ResponsiveUtils.isSmallScreen(context) ? CustomSeparator(height: screenHeight * 0.1):SizedBox(),
                                  !ResponsiveUtils.isSmallScreen(context) ? const SizedBox() : LoginBanner(),
                                  CustomSeparator(height: screenHeight * 0.05),
                                  _widgetTitle(context),
                                  CustomSeparator(height: screenHeight * 0.1),
                                  _builderForm()
                                ]
                              ),
                            )
                        ),
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
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.clientHome, (route) => false);
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
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(controller: usernameController, hintText: "Usuario"),
          CustomSeparator(height: 16),
          CustomTextFormField(controller: passwordController, hintText: "Contraseña", obscureText: true,),
          CustomSeparator(height: 16),
          _widgetButtonSignIn(context),
          ResponsiveUtils.isSmallScreen(context)? CustomSeparator(height: 16): const SizedBox(),
          _widgetTextButtonForgotPassword(context),
          _widgetTextButtonSignUp(context)
        ],
      ),
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
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
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
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.register);
      },
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
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
            )
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
