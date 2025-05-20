// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTableAdapter extends TypeAdapter<UserTable> {
  @override
  final int typeId = 0;

  @override
  UserTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTable()
      ..document = fields[0] as String
      ..name = fields[2] as String?
      ..session = fields[3] as String?
      ..pendingUpdate = fields[4] as bool?
      ..yesIPreacher = fields[5] as bool?;
  }

  @override
  void write(BinaryWriter writer, UserTable obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.document)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.session)
      ..writeByte(4)
      ..write(obj.pendingUpdate)
      ..writeByte(5)
      ..write(obj.yesIPreacher);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
