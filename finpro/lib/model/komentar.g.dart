// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komentar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KomentarAdapter extends TypeAdapter<Komentar> {
  @override
  final int typeId = 0;

  @override
  Komentar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Komentar(
      resepId: fields[0] as String,
      username: fields[1] as String,
      komentar: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Komentar obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.resepId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.komentar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KomentarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
