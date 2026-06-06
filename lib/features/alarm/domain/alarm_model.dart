import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';
import 'package:waypoint_alarm/core/database/app_database.dart';

part 'alarm_model.mapper.dart';

enum AlarmTriggerBehavior {
  oneTime,
  dismissible,
}

@MappableClass()
class AlarmModel with AlarmModelMappable {
  const AlarmModel({
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.radiusMeters,
    required this.volumePercent,
    required this.triggerBehavior,
    required this.triggerDurationSeconds,
    required this.isActive,
    required this.createdAt,
    this.audioFilePath,
    this.id,
  });

  factory AlarmModel.fromEntity(Alarm alarm) {
    return AlarmModel(
      id: alarm.id,
      name: alarm.name,
      longitude: alarm.longitude,
      latitude: alarm.latitude,
      radiusMeters: alarm.radiusMeters,
      audioFilePath: alarm.audioFilePath,
      volumePercent: alarm.volumePercent,
      triggerBehavior: alarm.triggerBehavior,
      triggerDurationSeconds: Duration(seconds: alarm.triggerDurationSeconds),
      isActive: alarm.isActive,
      createdAt: alarm.createdAt,
    );
  }

  final int? id;
  final String name;
  final double longitude;
  final double latitude;
  final double radiusMeters;
  final String? audioFilePath;
  final int volumePercent;
  final AlarmTriggerBehavior triggerBehavior;
  final Duration triggerDurationSeconds;
  final bool isActive;
  final DateTime createdAt;

  AlarmsCompanion toEntityCompanion() {
    return AlarmsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
      radiusMeters: Value(radiusMeters),
      audioFilePath: audioFilePath != null
          ? Value(audioFilePath)
          : const Value.absent(),
      volumePercent: Value(volumePercent),
      triggerBehavior: Value(triggerBehavior),
      triggerDurationSeconds: Value(triggerDurationSeconds.inSeconds),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }
}
