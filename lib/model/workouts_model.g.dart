// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutModelAdapter extends TypeAdapter<WorkoutModel> {
  @override
  final int typeId = 0;

  @override
  WorkoutModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutModel(
      workoutId: fields[0] as String?,
      userId: fields[1] as String?,
      creatorName: fields[2] as String?,
      workoutName: fields[3] as String?,
      workoutType: fields[4] as String?,
      addedTo: (fields[5] as List?)?.cast<String>(),
      difficulty: fields[6] as String?,
      levelOf: fields[7] as String?,
      gender: fields[8] as String?,
      totalTime: fields[9] as int?,
      price: fields[10] as int?,
      dateTime: fields[11] as DateTime?,
      description: fields[12] as String?,
      categorizedVideos: (fields[13] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<VideoModel>())),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.workoutId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.creatorName)
      ..writeByte(3)
      ..write(obj.workoutName)
      ..writeByte(4)
      ..write(obj.workoutType)
      ..writeByte(5)
      ..write(obj.addedTo)
      ..writeByte(6)
      ..write(obj.difficulty)
      ..writeByte(7)
      ..write(obj.levelOf)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.totalTime)
      ..writeByte(10)
      ..write(obj.price)
      ..writeByte(11)
      ..write(obj.dateTime)
      ..writeByte(12)
      ..write(obj.description)
      ..writeByte(13)
      ..write(obj.categorizedVideos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
