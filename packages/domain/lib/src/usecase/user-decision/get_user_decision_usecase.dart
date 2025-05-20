import 'package:domain/domain.dart';

class GetUserDecisionUseCase {
  final UserRepository _repository;

  GetUserDecisionUseCase(this._repository);

  Future<Either<RegisterUserDecisionFailure, bool>> call() {
    return _repository.getUserDecision();
  }
}