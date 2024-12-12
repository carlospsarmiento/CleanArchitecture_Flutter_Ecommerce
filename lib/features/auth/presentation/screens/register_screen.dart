import 'package:app_flutter/features/auth/presentation/widgets/login_banner.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_state.dart';
import 'package:app_flutter/shared/presentation/widgets/custom_separator.dart';
import 'package:app_flutter/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                                ResponsiveUtils.isSmallScreen(context) ? CustomSeparator(height: screenHeight * 0.1):SizedBox(),
                                !ResponsiveUtils.isSmallScreen(context) ? const SizedBox() : LoginBanner(),
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

  }

  Widget _widgetTitle(BuildContext context){
    return Text(
      "Register",
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

          ],
        )
    );
  }
}