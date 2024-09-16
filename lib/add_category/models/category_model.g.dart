// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAddModelAdapter extends TypeAdapter<CategoryAddModel> {
  @override
  final int typeId = 1;

  @override
  CategoryAddModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryAddModel(
      parentId: fields[8] as String,
      id: fields[7] as String,
      name: fields[0] as String,
      parentName: fields[1] as String,
      detail01: fields[2] as String,
      detail02: fields[3] as String,
      recommender: fields[4] as String,
      notes: fields[5] as String,
      createdAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryAddModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.parentName)
      ..writeByte(2)
      ..write(obj.detail01)
      ..writeByte(3)
      ..write(obj.detail02)
      ..writeByte(4)
      ..write(obj.recommender)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.parentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAddModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
