import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:waypoint_alarm/core/providers/database_provider.dart';
import 'package:waypoint_alarm/features/alarm/data/alarm_repository.dart';

part 'alarm_provider.g.dart';

@riverpod
AlarmRepository alarmRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return AlarmRepository(dao: db.alarmDao);
}
