import 'package:entities/entities.dart';

abstract class NotificationRepository {

  Future<void> updateNotification();
  Future<List<Notification>> notifications();

}