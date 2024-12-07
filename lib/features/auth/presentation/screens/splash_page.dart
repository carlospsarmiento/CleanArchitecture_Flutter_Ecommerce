import 'package:app_flutter/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/features/auth/presentation/bloc/auth_state.dart';
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
    final authCubit = context.read<AuthCubit>();
    authCubit.checkUserLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) => _listenAuthCubit(context,state),
        child: Stack(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            )
          ],
        )
      ),
    );
  }

  void _listenAuthCubit(BuildContext context, AuthState state){

  }
}
