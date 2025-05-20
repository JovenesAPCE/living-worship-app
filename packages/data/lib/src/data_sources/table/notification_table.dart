import 'package:entities/entities.dart';
import 'package:hive/hive.dart';

part 'notification_table.g.dart';

@HiveType(typeId: 3)
class NotificationTable {
  @HiveField(0)
  late String id;
  @HiveField(1)
  String? body;
  @HiveField(2)
  String? image;
  @HiveField(3)
  int? row;
  @HiveField(4)
  String? date;


  Notification toEntity() => Notification(
      id: id,
      message: body??"",
      imageUrl: image??"",
      row: row??0,
      dateString: date??""
  );

  static NotificationTable fromEntity(Notification entity) => NotificationTable()
    ..id = entity.id
    ..image = entity.imageUrl
    ..body = entity.message
    ..row = entity.row
    ..date = entity.dateString
  ;
}