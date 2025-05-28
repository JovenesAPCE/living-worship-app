import 'package:domain/domain.dart';

class LogScreenUseCase {
  final AnalyticsRepository _repository;

  LogScreenUseCase(this._repository);

  Future<void> call(String screenName, String screenClass) {
    return _repository.logScreenView(screenName: screenName, screenClass: screenClass);
  }
}