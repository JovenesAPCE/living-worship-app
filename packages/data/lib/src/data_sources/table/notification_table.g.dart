// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationTableAdapter extends TypeAdapter<NotificationTable> {
  @override
  final int typeId = 3;

  @override
  NotificationTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationTable()
      ..id = fields[0] as String
      ..body = fields[1] as String?
      ..image = fields[2] as String?
      ..row = fields[3] as int?
      ..date = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, NotificationTable obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.row)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
