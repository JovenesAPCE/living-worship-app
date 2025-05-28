import 'package:domain/domain.dart';

class ConfigUserUseCase {
  final AnalyticsRepository _repository;

  ConfigUserUseCase(this._repository);

  Future<void> call(String name, String document) {
    return _repository.setUserProperty(name: name, document: document);
  }
}