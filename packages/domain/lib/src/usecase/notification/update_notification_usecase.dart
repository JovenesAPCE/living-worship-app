import 'package:domain/domain.dart';

class UpdateNotificationUseCase {

  final NotificationRepository _repository;

  UpdateNotificationUseCase(this._repository);

  Future<void> call() {
    return _repository.updateNotification();
  }
}