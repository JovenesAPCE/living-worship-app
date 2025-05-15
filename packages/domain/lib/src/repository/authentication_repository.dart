import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

abstract class AuthenticationRepository {

  Stream<AuthStatus> get status;

  Future<Either<LoginFailure, void>> logIn(String document, String year);

  Future<void> logOut();

  void dispose();

}