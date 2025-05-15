// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semi_plenary_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SemiPlenaryTableAdapter extends TypeAdapter<SemiPlenaryTable> {
  @override
  final int typeId = 1;

  @override
  SemiPlenaryTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SemiPlenaryTable()
      ..id = fields[0] as String
      ..color = fields[1] as String?
      ..group = fields[2] as String?
      ..issue = fields[3] as String?
      ..time = fields[4] as String?
      ..title = fields[5] as String?
      ..capacity = fields[6] as int?
      ..available = fields[7] as int?;
  }

  @override
  void write(BinaryWriter writer, SemiPlenaryTable obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.group)
      ..writeByte(3)
      ..write(obj.issue)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.capacity)
      ..writeByte(7)
      ..write(obj.available);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemiPlenaryTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
