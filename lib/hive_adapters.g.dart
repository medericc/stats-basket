// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 0;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      name: fields[0] as String,
      rebounds: fields[1] as int,
      assists: fields[2] as int,
      steals: fields[3] as int,
      blocks: fields[4] as int,
      turnovers: fields[5] as int,
      points: fields[6] as int,
      ftMade: fields[7] as int,
      ftMissed: fields[8] as int,
      twoPtMade: fields[9] as int,
      twoPtMissed: fields[10] as int,
      threePtMade: fields[11] as int,
      threePtMissed: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.rebounds)
      ..writeByte(2)
      ..write(obj.assists)
      ..writeByte(3)
      ..write(obj.steals)
      ..writeByte(4)
      ..write(obj.blocks)
      ..writeByte(5)
      ..write(obj.turnovers)
      ..writeByte(6)
      ..write(obj.points)
      ..writeByte(7)
      ..write(obj.ftMade)
      ..writeByte(8)
      ..write(obj.ftMissed)
      ..writeByte(9)
      ..write(obj.twoPtMade)
      ..writeByte(10)
      ..write(obj.twoPtMissed)
      ..writeByte(11)
      ..write(obj.threePtMade)
      ..writeByte(12)
      ..write(obj.threePtMissed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeamAdapter extends TypeAdapter<Team> {
  @override
  final int typeId = 1;

  @override
  Team read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Team(
      name: fields[0] as String,
      players: (fields[1] as List).cast<Player>(),
    );
  }

  @override
  void write(BinaryWriter writer, Team obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.players);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
