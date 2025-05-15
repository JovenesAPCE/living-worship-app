import 'package:domain/src/repository/repository.dart';

class LogOutUseCase {

  final AuthenticationRepository _repository;

  LogOutUseCase(this._repository);

  Future<void> call() {
    return _repository.logOut();
  }

}