import 'package:domain/domain.dart';

class LogInUseCase {

  final AuthenticationRepository repository;

  LogInUseCase(this.repository);

  Future<Either<LoginFailure, void>> call(String document, String year) {
    return repository.logIn(document, year);
  }
}