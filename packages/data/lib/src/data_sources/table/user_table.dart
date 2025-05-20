import 'package:entities/entities.dart';
import 'package:hive/hive.dart';

part 'user_table.g.dart';

@HiveType(typeId: 0)
class UserTable {

  @HiveField(0)
  late String document; // campo único (clave externa lógica)


  @HiveField(2)
  String? name;

  @HiveField(3)
  String? session;

  @HiveField(4)
  bool? pendingUpdate;

  @HiveField(5)
  bool? yesIPreacher;

  // Convertir modelo -> entidad
  User toEntity() => User(document: document, name: name, session: session);

  // Convertir entidad -> modelo
  static UserTable fromEntity(User entity) => UserTable()
    ..document = entity.document
    ..name = entity.name
    ..session = entity.session;

}