import 'package:data/data.dart';
import 'package:data/src/firbase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class NotificationHandler {

  static String? _initialPayload;
  static Future<void> initNotification({required bool kDebugMode, required bool isWebNotify}) async {
    print("isWebNotify: $isWebNotify");
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    print('App abierta desde notificación (cerrada totalmente): ${initialMessage?.senderId}');
    if (initialMessage != null) {
      _initialPayload = "initialPayload";
      if (kDebugMode)print('App abierta desde notificación (cerrada totalmente): ${initialMessage.data}');
    }
    if(isWebNotify){
      _initialPayload = "initialPayload";
    }
  }

  static bool wasOpenedFromNotification(){
    bool show = _initialPayload != null;
    print("_initialPayload: $_initialPayload");
    _initialPayload = null; // limpia después de usarlo

    return show;
  }


}

