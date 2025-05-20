import 'package:data/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:jamt/app.dart';
import 'package:jamt/firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init(); // <- pasa explícitamente si es web
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await NotificationHandler.init(); // 👈 carga el payload

  runApp(App());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("🔔 Background notification: \${message.messageId}");
}

class NotificationHandler {
  static String? initialPayload;

  static Future<void> init() async {
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      initialPayload = "initialPayload";
      print('App abierta desde notificación (cerrada totalmente): ${initialMessage.data}');
    }
  }
}