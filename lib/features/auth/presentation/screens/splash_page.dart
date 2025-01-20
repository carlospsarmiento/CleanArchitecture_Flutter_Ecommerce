import 'package:app_flutter/core/routes/app_routes.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_state.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    final context = this.context;
    Future.delayed(Duration(seconds: 2),(){
      if(context.mounted){
        final authCubit = context.read<AuthCubit>();
        authCubit.checkUserLogged();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) => _listenAuthCubit(context,state),
        child: Center(
          child: Text(
              "Ecommerce App",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary
              ),
          ),
        )
      ),
    );
  }

  void _listenAuthCubit(BuildContext context, AuthState state){
    if(state is AuthCheckUserLoggedSuccessState){
      if(state.userLogged!=null){
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.clientHome, (route) => false);
      }
      else{
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
      }
    }
    if(state is AuthCheckUserLoggedFailState){
      CustomSnackBar.show(context, message: state.message);
    }
  }
}
