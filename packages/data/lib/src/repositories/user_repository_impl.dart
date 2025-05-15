import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import '../data_sources/data_sources.dart';

class UserRepositoryImpl extends UserRepository {

  @override
  Future<User?> getUser() async {
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if(user == null) return null;
    return User(
      document: user.document,
      name: user.name
    );
  }

}