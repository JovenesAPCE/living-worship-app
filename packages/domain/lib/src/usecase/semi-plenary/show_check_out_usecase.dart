import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class ShowCheckOutUseCase {
  final SemiPlenaryRepository _repository;

  ShowCheckOutUseCase(this._repository);

  Future<void> call(SemiPlenary semiPlenary, bool copy) {
    return _repository.showCheckOut(semiPlenary.id, copy);
  }

}