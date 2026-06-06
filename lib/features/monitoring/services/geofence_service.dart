import 'package:latlong2/latlong.dart';
import 'package:waypoint_alarm/core/constants/alarm_defaults.dart';
import 'package:waypoint_alarm/features/alarm/domain/alarm_model.dart';

class GeofenceEvaluationResult {
  const GeofenceEvaluationResult({
    required this.triggeredAlarms,
    required this.minimumDistanceMeters,
    required this.recommendedPollingInterval,
  });

  final List<AlarmModel> triggeredAlarms;
  final double minimumDistanceMeters;
  final Duration recommendedPollingInterval;
}

class GeofenceService {
  GeofenceService() : _distanceCalculator = const Distance();

  final Distance _distanceCalculator;
  final Set<int> _alreadyTriggeredAlarmIds = {};

  GeofenceEvaluationResult evaluate(
    double currentLatitude,
    double currentLongitude,
    List<AlarmModel> activeAlarms,
  ) {
    if (activeAlarms.isEmpty) {
      return const GeofenceEvaluationResult(
        triggeredAlarms: [],
        minimumDistanceMeters: double.infinity,
        recommendedPollingInterval: kFarPollingInterval,
      );
    }

    final currentLatLng = LatLng(currentLatitude, currentLongitude);
    final triggeredAlarms = <AlarmModel>[];
    var minDistance = double.infinity;

    for (final alarm in activeAlarms) {
      final alarmLatLng = LatLng(alarm.latitude, alarm.longitude);
      final distanceToAlarm = _distanceCalculator(currentLatLng, alarmLatLng);

      if (distanceToAlarm < minDistance) {
        minDistance = distanceToAlarm;
      }

      if (distanceToAlarm <= alarm.radiusMeters) {
        if (alarm.id != null && !_alreadyTriggeredAlarmIds.contains(alarm.id)) {
          triggeredAlarms.add(alarm);
          _alreadyTriggeredAlarmIds.add(alarm.id!);
        }
      } else {
        if (alarm.id != null) {
          _alreadyTriggeredAlarmIds.remove(alarm.id);
        }
      }
    }

    Duration recommendedInterval;
    if (minDistance > kFarDistanceThresholdMeters) {
      recommendedInterval = kFarPollingInterval;
    } else if (minDistance > kMediumDistanceThresholdMeters) {
      recommendedInterval = kMediumPollingInterval;
    } else {
      recommendedInterval = kNearPollingInterval;
    }

    return GeofenceEvaluationResult(
      triggeredAlarms: triggeredAlarms,
      minimumDistanceMeters: minDistance,
      recommendedPollingInterval: recommendedInterval,
    );
  }

  void clearTriggeredState(int alarmId) {
    _alreadyTriggeredAlarmIds.remove(alarmId);
  }

  void clearAllTriggeredStates() {
    _alreadyTriggeredAlarmIds.clear();
  }
}
