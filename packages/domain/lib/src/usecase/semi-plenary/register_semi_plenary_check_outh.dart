import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class RegisterSemiPlenaryCheckOutUseCase {

  final SemiPlenaryRepository _repository;

  RegisterSemiPlenaryCheckOutUseCase(this._repository);

  Future<Either<RegisterSemiPlenaryFailure,void>> call(QRData qrData) {
    return _repository.registerSemiPlenaryCheckOut(qrData);
  }

}

