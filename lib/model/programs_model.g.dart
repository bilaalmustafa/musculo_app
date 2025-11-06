// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'programs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgramModelAdapter extends TypeAdapter<ProgramModel> {
  @override
  final int typeId = 2;

  @override
  ProgramModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgramModel(
      userId: fields[0] as String?,
      programId: fields[15] as String?,
      creatorName: fields[1] as String?,
      programName: fields[2] as String?,
      typeOf: fields[3] as String?,
      levelOf: fields[4] as String?,
      duration: fields[5] as int?,
      timeAWeek: fields[6] as int?,
      dayAWeek: (fields[7] as List?)?.cast<String>(),
      intended: fields[8] as String?,
      price: fields[9] as num?,
      totalTime: fields[10] as int?,
      rating: fields[12] as double?,
      ratingCount: fields[13] as int?,
      review: (fields[14] as List?)?.cast<String>(),
      listOfWorkoutIds: (fields[11] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProgramModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.creatorName)
      ..writeByte(2)
      ..write(obj.programName)
      ..writeByte(3)
      ..write(obj.typeOf)
      ..writeByte(4)
      ..write(obj.levelOf)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.timeAWeek)
      ..writeByte(7)
      ..write(obj.dayAWeek)
      ..writeByte(8)
      ..write(obj.intended)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.totalTime)
      ..writeByte(11)
      ..write(obj.listOfWorkoutIds)
      ..writeByte(12)
      ..write(obj.rating)
      ..writeByte(13)
      ..write(obj.ratingCount)
      ..writeByte(14)
      ..write(obj.review)
      ..writeByte(15)
      ..write(obj.programId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
