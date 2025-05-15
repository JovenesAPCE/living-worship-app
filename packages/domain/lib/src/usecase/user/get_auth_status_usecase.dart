import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

class GetAuthStatusUseCase {
  final AuthenticationRepository repository;

  GetAuthStatusUseCase(this.repository);

  Stream<AuthStatus> call() {
    return repository.status;
  }
}