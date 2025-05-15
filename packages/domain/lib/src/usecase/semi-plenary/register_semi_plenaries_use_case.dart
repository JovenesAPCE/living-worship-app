import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class RegisterSemiPlenariesUseCase {

  final SemiPlenaryRepository _repository;

  RegisterSemiPlenariesUseCase(this._repository);

  Future<Either<RegisterSemiPlenaryFailure,void>> call(List<SemiPlenary> semiPlenaries) {
     return _repository.registerSemiPlenary(semiPlenaries);
  }

}

