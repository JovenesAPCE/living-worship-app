import 'package:domain/domain.dart';

class UnsubscribeNotificationUseCase {
  final NotificationRepository _repository;

  UnsubscribeNotificationUseCase(this._repository);

  Future<void> call() {
    return _repository.unsubscribeNotification();
  }
}