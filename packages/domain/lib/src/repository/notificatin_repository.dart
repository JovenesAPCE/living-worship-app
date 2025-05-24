import 'package:entities/entities.dart';

abstract class NotificationRepository {
  Stream<Notification> get notificationReceived;
  Future<void> updateNotification();
  Future<List<Notification>> notifications();
  Future<bool> wasOpenNotification();

}