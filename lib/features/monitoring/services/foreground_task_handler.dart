import 'dart:async';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:waypoint_alarm/core/constants/alarm_defaults.dart';
import 'package:waypoint_alarm/core/database/app_database.dart';
import 'package:waypoint_alarm/core/database/daos/alarm_dao.dart';
import 'package:waypoint_alarm/features/alarm/domain/alarm_model.dart';
import 'package:waypoint_alarm/features/monitoring/services/alert_service.dart';
import 'package:waypoint_alarm/features/monitoring/services/geofence_service.dart';

@pragma('vm:entry-point')
void monitoringStartCallback() {
  FlutterForegroundTask.setTaskHandler(MonitoringTaskHandler());
}

class MonitoringTaskHandler extends TaskHandler {
  late AppDatabase _db;
  late AlarmDao _alarmDao;
  late GeofenceService _geofenceService;
  late AlertService _alertService;

  StreamSubscription<Position>? _positionStreamSub;
  Position? _lastPosition;
  Duration _currentInterval = kFarPollingInterval;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    _db = AppDatabase();
    _alarmDao = AlarmDao(_db);
    _geofenceService = GeofenceService();
    _alertService = AlertService(_db);

    _positionStreamSub =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        ).listen((position) {
          _lastPosition = position;
        });
  }

  @override
  Future<void> onRepeatEvent(DateTime timestamp) async {
    if (_lastPosition == null) return;

    final activeEntities = await _alarmDao.getActiveAlarms();
    final activeAlarms = activeEntities.map(AlarmModel.fromEntity).toList();

    final result = _geofenceService.evaluate(
      _lastPosition!.latitude,
      _lastPosition!.longitude,
      activeAlarms,
    );

    for (final alarm in result.triggeredAlarms) {
      await _alertService.triggerAlert(alarm);
    }

    final newInterval = result.recommendedPollingInterval;
    if (newInterval != _currentInterval) {
      _currentInterval = newInterval;
      unawaited(
        FlutterForegroundTask.updateService(
          foregroundTaskOptions: ForegroundTaskOptions(
            eventAction: ForegroundTaskEventAction.repeat(
              newInterval.inMilliseconds,
            ),
            autoRunOnBoot: true,
            allowWifiLock: true,
          ),
        ),
      );
    }

    final count = activeAlarms.length;

    final singularText = await FlutterForegroundTask.getData<String>(
      key: 'monitoringNotificationSingular',
    );
    final pluralTextTemplate = await FlutterForegroundTask.getData<String>(
      key: 'monitoringNotificationPlural',
    );

    final text = count == 1
        ? singularText
        : pluralTextTemplate?.replaceAll('{count}', count.toString());

    unawaited(
      FlutterForegroundTask.updateService(
        notificationText: text,
      ),
    );
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    await _positionStreamSub?.cancel();
    _alertService.dispose();
    await _db.close();
  }

  @override
  Future<void> onNotificationButtonPressed(String id) async {
    if (id.startsWith('dismiss_')) {
      final alarmId = int.tryParse(id.split('_').last);
      if (alarmId != null) {
        await _alertService.dismissAlert(alarmId);
        await _alarmDao.toggleAlarmActive(alarmId, isActive: false);
      }
    } else if (id == 'pause_all') {
      final activeEntities = await _alarmDao.getActiveAlarms();
      for (final entity in activeEntities) {
        await _alarmDao.toggleAlarmActive(entity.id, isActive: false);
        await _alertService.dismissAlert(entity.id);
      }
    } else if (id == 'view_alarms') {
      FlutterForegroundTask.launchApp();
    }
  }

  @override
  void onReceiveData(Object data) {
    if (data is Map) {
      final action = data['action'];
      if (action == 'dismiss') {
        final alarmId = data['alarmId'] as int?;
        if (alarmId != null) {
          _alertService.dismissAlert(alarmId).ignore();
          _alarmDao.toggleAlarmActive(alarmId, isActive: false).ignore();
        }
      }
    }
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp();
  }
}
