import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class GetRegisterSemiPlenariesUseCase {

  final SemiPlenaryRepository _repository;

  GetRegisterSemiPlenariesUseCase(this._repository);

  Future<List<RegisterSemiPlenary>> call() {
     return _repository.getRegisterSemiPlenaries();
  }

}

