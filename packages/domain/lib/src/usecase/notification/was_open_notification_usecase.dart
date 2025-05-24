import 'package:domain/domain.dart';

class WasOpenNotificationUseCase {
  final NotificationRepository _repository;

  WasOpenNotificationUseCase(this._repository);

  Future<bool> call() {
    return _repository.wasOpenNotification();
  }
}