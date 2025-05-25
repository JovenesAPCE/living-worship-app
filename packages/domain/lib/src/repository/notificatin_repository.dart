import 'package:entities/entities.dart';

abstract class NotificationRepository {
  Stream<Notification> get notificationReceived;
  Future<void> updateNotification();
  Future<List<Notification>> notifications();
  Future<bool> wasOpenNotification();
  Future<void> unsubscribeNotification();

  Future<String> subscribeNotification();

}