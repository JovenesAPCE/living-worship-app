import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class GetQrStateSemiPlenaryUseCase {
  final SemiPlenaryRepository _repository;

  GetQrStateSemiPlenaryUseCase(this._repository);

  Future<Either<RegisterSemiPlenaryFailure, QrStateSemiPlenary>> call() {
    return _repository.getQrStateSemiPlenary();
  }
}