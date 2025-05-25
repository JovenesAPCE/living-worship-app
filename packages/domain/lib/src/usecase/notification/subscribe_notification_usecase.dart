import 'package:domain/domain.dart';

class SubscribeNotificationUseCase {
  final NotificationRepository _repository;

  SubscribeNotificationUseCase(this._repository);

  Future<String> call() {
    return _repository.subscribeNotification();
  }
}