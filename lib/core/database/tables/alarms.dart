import 'package:drift/drift.dart';
import 'package:waypoint_alarm/features/alarm/domain/alarm_model.dart';

class Alarms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get radiusMeters => real()();
  TextColumn get audioFilePath => text().nullable()();
  IntColumn get volumePercent => integer().withDefault(const Constant(80))();
  IntColumn get triggerBehavior =>
      intEnum<AlarmTriggerBehavior>().withDefault(const Constant(0))();
  IntColumn get triggerDurationSeconds =>
      integer().withDefault(const Constant(30))();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
