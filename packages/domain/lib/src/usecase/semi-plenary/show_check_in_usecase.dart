import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class ShowCheckInUseCase {
  final SemiPlenaryRepository _repository;

  ShowCheckInUseCase(this._repository);

  Future<void> call(SemiPlenary semiPlenary) {
    return _repository.showCheckIn(semiPlenary.id);
  }

}