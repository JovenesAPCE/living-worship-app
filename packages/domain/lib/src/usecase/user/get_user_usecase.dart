import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class GetUserUseCase {

  final UserRepository _repository;

  GetUserUseCase(this._repository);

  Future<User?> call() {
    return _repository.getUser();
  }
}