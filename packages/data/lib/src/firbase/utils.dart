import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FBUtils {

  static Future<void> trySetCrashlyticsUser(String document) async {
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier(document);
    } catch (e) {
      print('Otro error al configurar Crashlytics: $e');
    }
  }

  static Future<void> tryLog(String message) async {
    try {
      await FirebaseCrashlytics.instance.log(message);
    } catch (e) {
      print('Otro error al configurar Crashlytics: $e');
    }
  }

  static Future<void> tryRecordError(e, {StackTrace? stack}) async {
    try {
      await FirebaseCrashlytics.instance.recordError(e, stack ?? StackTrace.current);
    } catch (e) {
      print('Otro error al configurar Crashlytics: $e');
    }
  }

}