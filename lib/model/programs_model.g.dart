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
      id: fields[0] as String?,
      creatorName: fields[1] as String?,
      programName: fields[2] as String?,
      typeOf: fields[3] as String?,
      levelOf: fields[4] as String?,
      duration: fields[5] as int?,
      timeAWeek: fields[6] as String?,
      dayAWeek: (fields[7] as List?)?.cast<String>(),
      intended: fields[8] as String?,
      price: fields[9] as int?,
      totalTime: fields[10] as int?,
      listOfWorkouts: (fields[11] as List?)?.cast<WorkoutModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProgramModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
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
      ..write(obj.listOfWorkouts);
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
