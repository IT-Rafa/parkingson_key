// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase_node.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhraseNodeAdapter extends TypeAdapter<PhraseNode> {
  @override
  final int typeId = 1;

  @override
  PhraseNode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhraseNode(
      id: fields[0] as String,
      title: fields[1] as String,
      isCategory: fields[2] as bool,
      children: (fields[3] as List).cast<PhraseNode>(),
      ttsEnabled: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PhraseNode obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isCategory)
      ..writeByte(3)
      ..write(obj.children)
      ..writeByte(4)
      ..write(obj.ttsEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhraseNodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
