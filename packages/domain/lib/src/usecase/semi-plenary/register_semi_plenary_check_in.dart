import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class RegisterSemiPlenaryCheckInUseCase {

  final SemiPlenaryRepository _repository;

  RegisterSemiPlenaryCheckInUseCase(this._repository);

  Future<Either<RegisterSemiPlenaryFailure,void>> call(QRData qrData) {
    return _repository.registerSemiPlenaryCheckIn(qrData);
  }

}

