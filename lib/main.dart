import 'package:data/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:jamt/app.dart';
import 'package:jamt/feature/bulletin/view/bulletin_web_notify.dart';

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
  print("base: ${Uri.base.fragment}");
  print("routeName: ${BulletinWebNotify.routeName}");
  await NotificationHandler.initNotification(
    kDebugMode: kDebugMode,
    isWebNotify: Uri.base.fragment == BulletinWebNotify.routeName
  );

  runApp(App());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("🔔 Background notification: \${message.messageId}");
}

