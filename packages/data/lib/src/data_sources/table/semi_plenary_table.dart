import 'package:entities/entities.dart';
import 'package:hive/hive.dart';

part 'semi_plenary_table.g.dart';


@HiveType(typeId: 1)
class SemiPlenaryTable {

  @HiveField(0)
  late String id;
  @HiveField(1)
  String? color;
  @HiveField(2)
  String? group;
  @HiveField(3)
  String? issue;
  @HiveField(4)
  String? time;
  @HiveField(5)
  String? title;
  @HiveField(6)
  int? capacity;
  @HiveField(7)
  int? available;
  @HiveField(8)
  String? gender;

  SemiPlenary toEntity() => SemiPlenary(
    id: id,
    color: color,
    group: group,
    issue: issue,
    title: title,
    time: time,
    capacity: capacity,
      available : available,
    gender: gender
  );

  static SemiPlenaryTable fromEntity(SemiPlenary entity) => SemiPlenaryTable()
    ..id = entity.id
    ..color = entity.color
    ..group = entity.group
    ..issue = entity.issue
    ..title = entity.title
    ..time = entity.time
    ..capacity = entity.capacity
      ..available = entity.available
      ..gender = entity.gender
  ;

}