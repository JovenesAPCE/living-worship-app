import 'package:entities/entities.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';

extension RemoteMessageMapper on RemoteMessage {
  Notification toEntity() {
    print("meessaa f");
    return Notification(
      id: Uuid().v4(),
      title: notification?.title??'',
      message: notification?.body ?? '',
      imageUrl: '',
      dateString: '',
    );
  }
}