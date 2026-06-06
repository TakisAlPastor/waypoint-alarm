import 'package:waypoint_alarm/core/database/daos/alarm_dao.dart';
import 'package:waypoint_alarm/features/alarm/domain/alarm_model.dart';

class AlarmRepository {
  AlarmRepository({required this.dao});

  final AlarmDao dao;

  Stream<List<AlarmModel>> watchAllAlarms() => dao.watchAllAlarms().map(
    (entities) => entities.map(AlarmModel.fromEntity).toList(),
  );

  Stream<List<AlarmModel>> watchActiveAlarms() => dao.watchActiveAlarms().map(
    (entities) => entities.map(AlarmModel.fromEntity).toList(),
  );

  Future<List<AlarmModel>> getAllAlarms() async {
    final entities = await dao.getAllAlarms();
    return entities.map(AlarmModel.fromEntity).toList();
  }

  Future<List<AlarmModel>> getActiveAlarms() async {
    final entities = await dao.getActiveAlarms();
    return entities.map(AlarmModel.fromEntity).toList();
  }

  Future<AlarmModel> getAlarmById(int id) async {
    final entity = await dao.getAlarmById(id);
    return AlarmModel.fromEntity(entity);
  }

  Future<int> addAlarm(AlarmModel alarm) =>
      dao.insertAlarm(alarm.toEntityCompanion());

  Future<bool> updateAlarm(AlarmModel alarm) =>
      dao.updateAlarm(alarm.toEntityCompanion());

  Future<int> deleteAlarmById(int id) => dao.deleteAlarmById(id);

  Future<void> toggleAlarmStatus(int id, {required bool isActive}) =>
      dao.toggleAlarmActive(id, isActive: isActive);
}
