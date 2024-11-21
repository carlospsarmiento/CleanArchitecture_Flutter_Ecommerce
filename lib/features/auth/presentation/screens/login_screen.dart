import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
                  _widgetLogo(),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  _widgetTitle(context),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  _widgetForm(context)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _widgetLogo(){
    return Image.network(
      "https://i.postimg.cc/nz0YBQcH/Logo-light.png",
      height: 100,
    );
  }

  Widget _widgetTitle(BuildContext context){
    return Text(
      "Sign In",
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _widgetForm(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _widgetTextFieldUsername(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: _widgetTextFieldPassword()
          ),
          _widgetButtonSignIn(),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.64),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text.rich(
              const TextSpan(
                text: "Don’t have an account? ",
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(color: Color(0xFF00BF6D)),
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetTextFieldUsername(){
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Usuario',
        filled: true,
        fillColor: Color(0xFFF5FCF9),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0 * 1.5, vertical: 16.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
          BorderRadius.all(Radius.circular(50)),
        ),
      ),
      keyboardType: TextInputType.phone,
      onSaved: (phone) {
        // Save it
      },
    );
  }

  Widget _widgetTextFieldPassword(){
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Contraseña',
        filled: true,
        fillColor: Color(0xFFF5FCF9),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0 * 1.5, vertical: 16.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
          BorderRadius.all(Radius.circular(50)),
        ),
      ),
      onSaved: (passaword) {
        // Save it
      },
    );
  }

  Widget _widgetButtonSignIn(){
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // Navigate to the main screen
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: const Color(0xFF00BF6D),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: const StadiumBorder(),
      ),
      child: const Text("Ingresar"),
    );
  }
}
