import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:waypoint_alarm/features/alarm/domain/alarm_model.dart';
import 'package:waypoint_alarm/features/alarm/providers/alarm_provider.dart';

part 'active_alarm_list_provider.g.dart';

@riverpod
Stream<List<AlarmModel>> activeAlarmList(Ref ref) {
  final repository = ref.watch(alarmRepositoryProvider);
  return repository.watchActiveAlarms();
}
