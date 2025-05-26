import 'package:domain/domain.dart';

class UpdateSemiPlenariesUseCase {

  final SemiPlenaryRepository _repository;

  UpdateSemiPlenariesUseCase(this._repository);

  Future<Either<RegisterSemiPlenaryFailure,void>> call() {
    return _repository.updateSemiPlenaries();
  }
}