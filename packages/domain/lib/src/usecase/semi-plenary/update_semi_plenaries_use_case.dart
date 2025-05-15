import 'package:domain/domain.dart';

class UpdateSemiPlenariesUseCase {

  final SemiPlenaryRepository _repository;

  UpdateSemiPlenariesUseCase(this._repository);

  Future<void> call() {
    return _repository.updateSemiPlenaries();
  }
}