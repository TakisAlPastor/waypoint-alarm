import 'package:drift/drift.dart';

import 'package:waypoint_alarm/core/database/app_database.dart';
import 'package:waypoint_alarm/core/database/tables/alarms.dart';

part 'alarm_dao.g.dart';

@DriftAccessor(tables: [Alarms])
class AlarmDao extends DatabaseAccessor<AppDatabase> with _$AlarmDaoMixin {
  AlarmDao(super.attachedDatabase);

  Stream<List<Alarm>> watchAllAlarms() => select(alarms).watch();

  Stream<List<Alarm>> watchActiveAlarms() {
    return (select(alarms)..where((t) => t.isActive.equals(true))).watch();
  }

  Future<List<Alarm>> getAllAlarms() => select(alarms).get();

  Future<List<Alarm>> getActiveAlarms() {
    return (select(alarms)..where((t) => t.isActive.equals(true))).get();
  }

  Future<Alarm> getAlarmById(int id) {
    return (select(alarms)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> insertAlarm(AlarmsCompanion entry) {
    return into(alarms).insert(entry);
  }

  Future<bool> updateAlarm(AlarmsCompanion entry) {
    return update(alarms).replace(entry);
  }

  Future<int> deleteAlarmById(int id) {
    return (delete(alarms)..where((t) => t.id.equals(id))).go();
  }

  Future<void> toggleAlarmActive(int id, {required bool isActive}) {
    return (update(alarms)..where((t) => t.id.equals(id))).write(
      AlarmsCompanion(
        isActive: Value(isActive),
      ),
    );
  }
}
