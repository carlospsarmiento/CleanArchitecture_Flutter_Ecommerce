import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  /*
                  FilledButton(
                      onPressed: (){},
                      child: Text("FilledButton")
                  ),
                  OutlinedButton(
                      onPressed: (){},
                      child: Text("OutlinedButton")),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        elevation: 1
                    ),
                    child: Text("ElevatedButton"),
                  ),
                  Switch(
                      value: false,
                      onChanged: (value){}),
                  */
                  SizedBox(height: screenHeight * 0.1),
                  _widgetLogo(),
                  SizedBox(height: screenHeight * 0.1),
                  _widgetTitle(context),
                  SizedBox(height: screenHeight * 0.05),
                  _widgetForm(context)
                ],
              ),
            )
        ),
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
    /*
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // Navigate to the main screen
          }
        },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        minimumSize: const Size(double.infinity,52)
      ),
      child: Text("Ingresar")
    );
    */
    return SizedBox(
      width: MediaQuery.of(context).size.width ,
      child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Navigate to the main screen
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
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
                  color: Theme.of(context).colorScheme.primary
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
              .bodyLarge!
              .color!
              .withOpacity(0.64),
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
