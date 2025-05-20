import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class SaveUserDecisionUseCase {
  final UserRepository _repository;

  SaveUserDecisionUseCase(this._repository);

  Future<Either<RegisterUserDecisionFailure, void>> call(RegisterUserDecision decision) {
    return _repository.registerUserDecision(decision);
  }
}