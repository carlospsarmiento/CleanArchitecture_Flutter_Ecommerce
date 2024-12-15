import 'dart:io';
import 'package:app_flutter/features/auth/presentation/widgets/login_banner.dart';
import 'package:app_flutter/shared/domain/entity/user.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_state.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_progress_dialog.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_separator.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_snackbar.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_textformfield.dart';
import 'package:app_flutter/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocListener<AuthCubit,AuthState>(
        listener: (context, state) => _listenAuthCubit(context,state),
        child: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    ResponsiveUtils.isSmallScreen(context)? const SizedBox() : Expanded(child: LoginBanner()),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                              children: [
                                CustomSeparator(height: screenHeight * 0.05),
                                _widgetImageProfile(),
                                CustomSeparator(height: screenHeight * 0.05),
                                _widgetTitle(context),
                                CustomSeparator(height: screenHeight * 0.1),
                                _builderForm()
                              ]
                          ),
                        )
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

  void _listenAuthCubit(BuildContext context, AuthState state){
    if(state is AuthSignupLoadingState){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => CustomProgressDialog(message: "Registrando su cuenta...")
      );
    }
    if (state is AuthSignupSuccessState) {
      Navigator.of(context).pop();
      CustomSnackBar.show(context, message: "Su cuenta ha sido creada correctamente, ya puede iniciar sesión");
    }
    if (state is AuthSignupFailState) {
      Navigator.of(context).pop();
      CustomSnackBar.show(context, message: state.message);
    }
  }

  Widget _widgetImageProfile(){
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          backgroundImage: _image != null ? FileImage(_image!) : null,
          child: _image == null ? Icon(Icons.person, size: 60) : null,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: _getImage,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.camera_alt, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _widgetTitle(BuildContext context){
    return Text(
      "Registro",
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.bold
      ),
    );
  }

  Widget _builderForm(){
    return BlocBuilder<AuthCubit,AuthState>(
        builder: (context, authState){
          return _widgetForm(context);
        }
    );
  }

  Widget _widgetForm(BuildContext context){
    return Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(controller: _emailController, hintText: "Email"),
            CustomSeparator(height: 16),
            CustomTextFormField(controller: _nameController, hintText: "Nombre"),
            CustomSeparator(height: 16),
            CustomTextFormField(controller: _lastNameController, hintText: "Apellido"),
            CustomSeparator(height: 16),
            CustomTextFormField(controller: _phoneController, hintText: "Teléfono"),
            CustomSeparator(height: 16),
            CustomTextFormField(controller: _passwordController, hintText: "Contraseña"),
            CustomSeparator(height: 16),
            CustomTextFormField(controller: _repeatPasswordController, hintText: "Repetir Contraseña"),
            CustomSeparator(height: 16),
            _widgetButtonSignUp(context),
            CustomSeparator(height: 16),
            _widgetTextButtonSignIn(context)
          ],
        )
    );
  }

  Widget _widgetButtonSignUp(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width ,
      child: FilledButton(
          onPressed: () {
            User user = User(
                name: _nameController.text,
                lastname: _lastNameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
                password: _passwordController.text);
            context.read<AuthCubit>().signUp(user, _image);
          },
          child: Text("Registrarme")
      ),
    );
  }

  // Función para abrir el selector de cámara o galería.
  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();

    // Preguntar al usuario si quiere usar la cámara o la galería.
    final XFile? image = await showDialog<XFile>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecciona una opción"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(await picker.pickImage(source: ImageSource.camera));
              },
              child: Text("Tomar foto"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(await picker.pickImage(source: ImageSource.gallery));
              },
              child: Text("Elegir de galería"),
            ),
          ],
        );
      },
    );

    if (image != null) {
      setState(() {
        _image = File(image.path); // Almacenar la imagen seleccionada.
      });
    }
  }

  Widget _widgetTextButtonSignIn(BuildContext context){
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text.rich(
        TextSpan(
          text: "¿Ya tienes una cuenta? ",
          children: [
            TextSpan(
              text: "Ingresa",
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