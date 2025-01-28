import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/core/notifications/firebase_notification_service.dart';
import 'package:app_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/address/client_address_map_screen.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/categories/pages/client_categories_screen.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/pages/client_home_screen.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/product_search/pages/client_product_search_screen.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:app_flutter/features/auth/presentation/screens/splash_page.dart';
import 'package:app_flutter/shared/presentation/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_routes.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Mensaje en segundo plano: ${message.notification?.title}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final firebaseNotificationService = FirebaseNotificationService();
  await firebaseNotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => di<AuthCubit>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(context),
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (BuildContext context) => SplashPage(),
          AppRoutes.login: (BuildContext context) => LoginScreen(),
          AppRoutes.register: (BuildContext context) => RegisterScreen(),
          AppRoutes.clientHome: (BuildContext context) => ClientHomeScreen(),
          AppRoutes.clientCategories: (BuildContext context) => ClientCategoriesScreen(),
          AppRoutes.clientProductSearch: (BuildContext context) => ClientProductSearchScreen(),
          AppRoutes.clientAddressMap : (BuildContext context) => ClientAddressMapScreen()
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