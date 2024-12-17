import 'package:app_flutter/core/di/di.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Este método se ejecuta para manejar mensajes en segundo plano
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Mensaje en segundo plano: ${message.notification?.title}");
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Configuramos las dependencias
  await initDi();
  // Inicializamos firebase
  await Firebase.initializeApp();
  // Configurar el handler para mensajes en segundo plano
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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

  String _message = "Esperando mensajes...";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
    _setupLocalNotifications();
  }

  void _setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Solicitar permisos (solo necesario para iOS)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permiso de notificaciones: ${settings.authorizationStatus}');

    // Obtener el token de registro
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // Listener para mensajes en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _message = "Mensaje recibido: ${message.notification?.title ?? 'Sin título'}";
      });
      print("Mensaje en primer plano: ${message.notification?.title}");
      _showLocalNotification(message);
    });

    // Listener para cuando se abre la app desde una notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notificación abierta: ${message.notification?.title}");
      setState(() {
        _message = "Notificación abierta: ${message.notification?.title ?? 'Sin título'}";
      });
    });
  }

  void _setupLocalNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Configuración para Android
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuración inicial
    const InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Mostrar notificación local cuando el mensaje llega en primer plano
  Future<void> _showLocalNotification(RemoteMessage message) async{
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'default_channel', // ID del canal
      'Default Notifications', // Nombre del canal
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0, // ID de la notificación
      message.notification?.title ?? 'Título no disponible',
      message.notification?.body ?? 'Contenido no disponible',
      notificationDetails,
    );
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