import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class GetSemiPlenariesUseCase {

  final SemiPlenaryRepository _repository;

  GetSemiPlenariesUseCase(this._repository);

  Future<List<SemiPlenary>> call() {
    return _repository.semiPlenaries();
  }
}