import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class GetQrStatusUseCase {
  final SemiPlenaryRepository repository;

  GetQrStatusUseCase(this.repository);

  Stream<QrStatus> call() {
    return repository.qrStatus;
  }
}