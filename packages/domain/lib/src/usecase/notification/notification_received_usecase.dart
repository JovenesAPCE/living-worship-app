import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class NotificationReceivedUseCase {
  final NotificationRepository repository;

  NotificationReceivedUseCase(this.repository);

  Stream<Notification> call() {
    return repository.notificationReceived;
  }
}