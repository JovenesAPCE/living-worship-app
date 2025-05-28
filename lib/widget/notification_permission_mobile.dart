import 'package:firebase_messaging/firebase_messaging.dart';

Future<bool> checkAndRequestPermission() async {
  NotificationSettings settings = await FirebaseMessaging.instance.getNotificationSettings();

  if (settings.authorizationStatus == AuthorizationStatus.notDetermined ||
      settings.authorizationStatus == AuthorizationStatus.denied) {
    await FirebaseMessaging.instance.requestPermission();
  }
  print('Permiso de notificaciones móvil: ${settings.authorizationStatus}');

  return settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional;
}