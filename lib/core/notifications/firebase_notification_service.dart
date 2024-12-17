import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _messaging;
  final LocalNotificationService _localNotificationService;

  FirebaseNotificationService()
      : _messaging = FirebaseMessaging.instance,
        _localNotificationService = LocalNotificationService();

  Future<void> initialize() async {
    await _requestPermission();
    await _localNotificationService.initialize();
    _setupFirebaseListeners();
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permiso de notificaciones: ${settings.authorizationStatus}');

    // Obtener el token de registro
    String? token = await _messaging.getToken();
    print("FCM Token: $token");
  }

  void _setupFirebaseListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _localNotificationService.showNotification(
        title: message.notification?.title ?? 'Título no disponible',
        body: message.notification?.body ?? 'Contenido no disponible',
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notificación abierta: ${message.notification?.title}");
    });
  }
}
