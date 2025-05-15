import 'package:entities/entities.dart';
import 'package:hive/hive.dart';

part 'register_semi_plenary_table.g.dart';

@HiveType(typeId: 2)
class RegisterSemiPlenaryTable {

  @HiveField(0)
  late String semiPlenary;
  @HiveField(1)
  late String document;
  @HiveField(2)
  DateTime? timestamp;
  @HiveField(3)
  late String group;
  @HiveField(4)
  late String title;
  @HiveField(5)
  bool? checkOut;
  @HiveField(6)
  DateTime? checkOutTimestamp;
  @HiveField(7)
  bool? checkIn;
  @HiveField(8)
  DateTime? checkInTimestamp;


  RegisterSemiPlenary toEntity() => RegisterSemiPlenary(
      semiPlenary: semiPlenary,
      document: document,
      timestamp: timestamp,
      group: group,
     title: title,
     checkOut: checkOut,
    checkOutTimestamp: checkOutTimestamp,
    checkIn: checkIn,
    checkInTimestamp: checkInTimestamp
  );

  static RegisterSemiPlenaryTable fromEntity(RegisterSemiPlenary entity) => RegisterSemiPlenaryTable()
    ..semiPlenary = entity.semiPlenary
    ..document = entity.document
    ..timestamp = entity.timestamp
      ..group = entity.group
      ..title = entity.title
      ..checkIn =  entity.checkIn
      ..checkInTimestamp = entity.checkInTimestamp
      ..checkOut = entity.checkOut
      ..checkOutTimestamp = entity.checkOutTimestamp
  ;

}