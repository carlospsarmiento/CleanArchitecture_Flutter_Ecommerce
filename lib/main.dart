import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/core/notifications/firebase_notification_service.dart';
import 'package:app_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/address/address_map_screen.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:app_flutter/features/auth/presentation/screens/splash_page.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/catalog/catalog_list_screen.dart';
import 'package:app_flutter/shared/presentation/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Handler global para mensajes en segundo plano
// este evento ocurre cuando el usuario tiene la app en segundo plano o cerrada y llega una notificacion
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Mensaje en segundo plano: ${message.notification?.title}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  await Firebase.initializeApp();

  // Configuración del handler de background (debe ser global y configurado después de Firebase.initializeApp)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final firebaseNotificationService = FirebaseNotificationService();
  await firebaseNotificationService.initialize();
  runApp(const MyApp());
  /*
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    )
  );
   */
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
        //home: LoginScreen()
        initialRoute: "auth/splash",
        routes: {
          "auth/splash": (BuildContext context) => SplashPage(),
          "auth/login": (BuildContext context) => LoginScreen(),
          "auth/register": (BuildContext context) => RegisterScreen(),
          "ecommerce/catalog/list": (BuildContext context) => CatalogListScreen(),
          "ecommerce/address/map" : (BuildContext context) => AddressMapScreen()
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