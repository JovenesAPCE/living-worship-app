import 'package:entities/entities.dart';

abstract class UserRepository {
  Future<User?> getUser();
}