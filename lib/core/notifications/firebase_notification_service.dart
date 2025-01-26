import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _messaging;
  final LocalNotificationService _localNotificationService;

  FirebaseNotificationService()
      : _messaging = FirebaseMessaging.instance,
        _localNotificationService = LocalNotificationService();


  // Configuramos las notificaciones push
  Future<void> initialize() async {
    await _requestPermission();
    await _localNotificationService.initialize();
    _setupFirebaseListeners();
  }

  // Solicitamos permisos al usuario para que pueda recibir notificaciones
  Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permiso de notificaciones: ${settings.authorizationStatus}');

    // Obtener un token de firebase, que es un token unico por dispositivo que puede ser utilizado para enviar notificaciones
    // a un determinado usuario
    String? token = await _messaging.getToken();
    print("FCM Token: $token");
  }

  // configuramos los listeners, en donde podemos realizar diversas acciones cuando recibimos una notificacion
  void _setupFirebaseListeners() {

    // este evento ocurre cuando el usuario tiene la app abierta y llega una notificacion
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _localNotificationService.showNotification(
        title: message.notification?.title ?? 'Título no disponible',
        body: message.notification?.body ?? 'Contenido no disponible',
      );
    });

    // este evento ocurre cuando el usuario hace click en una notificacion, aqui podriamos 
    // redirigirlo a alguna pagina
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notificación abierta: ${message.notification?.title}");
    });
  }
}
