import 'package:domain/domain.dart';

class GetPathWhatsAppGroupUseCase {
  final UserRepository _repository;

  GetPathWhatsAppGroupUseCase(this._repository);

  Future<Either<RegisterUserDecisionFailure, String>> call() {
    return _repository.getPathWhatsAppGroup();
  }
}