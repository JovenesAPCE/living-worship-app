import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class GetNotificationUseCase {

  final NotificationRepository _repository;

  GetNotificationUseCase(this._repository);

  Future<List<Notification>> call() {
    return _repository.notifications();
  }
}