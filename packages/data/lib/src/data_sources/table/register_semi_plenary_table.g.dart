// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_semi_plenary_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterSemiPlenaryTableAdapter
    extends TypeAdapter<RegisterSemiPlenaryTable> {
  @override
  final int typeId = 2;

  @override
  RegisterSemiPlenaryTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterSemiPlenaryTable()
      ..semiPlenary = fields[0] as String
      ..document = fields[1] as String
      ..timestamp = fields[2] as DateTime?
      ..group = fields[3] as String
      ..title = fields[4] as String
      ..checkOut = fields[5] as bool?
      ..checkOutTimestamp = fields[6] as DateTime?
      ..checkIn = fields[7] as bool?
      ..checkInTimestamp = fields[8] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, RegisterSemiPlenaryTable obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.semiPlenary)
      ..writeByte(1)
      ..write(obj.document)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.group)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.checkOut)
      ..writeByte(6)
      ..write(obj.checkOutTimestamp)
      ..writeByte(7)
      ..write(obj.checkIn)
      ..writeByte(8)
      ..write(obj.checkInTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterSemiPlenaryTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
