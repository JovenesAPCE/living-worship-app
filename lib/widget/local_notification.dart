import 'dart:io';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class LocalNotification {
// Singleton interno
  static final LocalNotification _instance = LocalNotification._internal();
  LocalNotification._internal();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  void Function(String? payload)? _onTapCallback;

  /// Establece el callback global para manejar toques en notificaciones
  static void setOnTapCallback(void Function(String? payload) callback) {
    _instance._onTapCallback = callback;
  }

  /// Método estático para mostrar una notificación local
  static Future<void> show({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_instance._isInitialized) {
      await _instance._initialize();
    }

    const androidDetails = AndroidNotificationDetails(
      'default_channel_id',
      'Notificaciones Generales',
      channelDescription: 'Canal para mensajes JAMT',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      color: Color(0xFF0064f9),
    );

    final details = NotificationDetails(android: androidDetails);
    final randomId = Random().nextInt(100000);

    await _instance._plugin.show(
      randomId,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// Inicialización interna (una sola vez)
  Future<void> _initialize() async {
    const androidSettings = AndroidInitializationSettings('ic_notification');
    final iosSettings = DarwinInitializationSettings();

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        _onTapCallback?.call(response.payload);
      },
    );

    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'default_channel_id',
        'Notificaciones Generales',
        description: 'Canal para mensajes JAMT',
        importance: Importance.high,
      );

      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    _isInitialized = true;
  }

}