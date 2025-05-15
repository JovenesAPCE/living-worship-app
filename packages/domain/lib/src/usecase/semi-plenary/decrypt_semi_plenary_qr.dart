import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class DecryptSemiPlenaryQr {
  final SemiPlenaryRepository _repository;

  DecryptSemiPlenaryQr(this._repository);

  Future<Either<RegisterSemiPlenaryFailure, QrState>> call(String fullQRText) {
    return _repository.readQr(fullQRText);
  }
}