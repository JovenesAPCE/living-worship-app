import 'package:domain/domain.dart';
import 'package:entities/entities.dart';

abstract class UserRepository {
  Future<User?> getUser();

  Future<Either<RegisterUserDecisionFailure, void>> registerUserDecision(RegisterUserDecision decision);

  Future<Either<RegisterUserDecisionFailure, String>> getPathWhatsAppGroup();

  Future<Either<RegisterUserDecisionFailure, bool>> getUserDecision();
}