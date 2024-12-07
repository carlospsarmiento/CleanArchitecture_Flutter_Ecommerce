import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/catalog_list_screen.dart';
import 'package:app_flutter/shared/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => di<AuthCubit>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,

        //home: LoginScreen()
        initialRoute: "auth/login",
        routes: {
          "auth/login": (BuildContext context) => LoginScreen(),
          "ecommerce/catalog/list": (BuildContext context) => CatalogListScreen(),
        },

        /*
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light
          ),
          useMaterial3: true,
          brightness: Brightness.light
        ),
        */
        //darkTheme: AppTheme.darkTheme,
        //themeMode: ThemeMode.system,
      ),
    );
  }
}