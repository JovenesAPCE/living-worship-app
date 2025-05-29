import 'package:domain/domain.dart';

class LogEventUseCase {
  final AnalyticsRepository _repository;

  LogEventUseCase(this._repository);

  Future<void> call({required String name, Map<String, Object>? parameters}) {
    return _repository.logEvent(name: name, parameters: parameters);
  }
}