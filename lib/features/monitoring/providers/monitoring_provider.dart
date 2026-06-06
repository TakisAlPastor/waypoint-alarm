import 'dart:async';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:waypoint_alarm/core/constants/alarm_defaults.dart';
import 'package:waypoint_alarm/core/routing/app_router.dart';
import 'package:waypoint_alarm/features/alarm/providers/active_alarm_list_provider.dart';
import 'package:waypoint_alarm/features/monitoring/services/foreground_task_handler.dart';
import 'package:waypoint_alarm/l10n/app_localizations.dart';
import 'package:waypoint_alarm/shared/utils/permission_helper.dart';

part 'monitoring_provider.g.dart';

@riverpod
class MonitoringService extends _$MonitoringService {
  @override
  void build() {
    ref.listen(activeAlarmListProvider, (previous, next) {
      final activeAlarms = next.hasValue ? next.requireValue : [];
      unawaited(_handleAlarmsStateChanged(activeAlarms.length));
    });
  }

  Future<void> _handleAlarmsStateChanged(int activeCount) async {
    final isRunning = await FlutterForegroundTask.isRunningService;

    if (activeCount > 0) {
      if (!isRunning) {
        final hasPermissions =
            await PermissionHelper.ensureMonitoringPermissions();
        if (hasPermissions) {
          await _startService();
        }
      }
    } else {
      if (isRunning) {
        await FlutterForegroundTask.stopService();
      }
    }
  }

  Future<void> _startService() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: kForegroundServiceChannelId,
        channelName: kForegroundServiceChannelName,
        channelDescription: 'Monitors location for active alarms',
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(
          kFarPollingInterval.inMilliseconds,
        ),
        autoRunOnBoot: true,
        allowWifiLock: true,
      ),
    );

    var initialTitle = 'Waypoint Alarm';
    var initialText = 'Iniciando monitoreo...';

    // Intentar obtener el contexto para enviar traducciones al isolate
    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      final l10n = AppLocalizations.of(context);
      if (l10n != null) {
        initialTitle = l10n.monitoringNotificationTitle;
        initialText = l10n.monitoringStarted;

        await FlutterForegroundTask.saveData(
          key: 'alertTriggeredTitle',
          value: l10n.alertTriggeredTitle,
        );
        await FlutterForegroundTask.saveData(
          key: 'alertTriggeredBody',
          value: l10n.alertTriggeredBody,
        );
        await FlutterForegroundTask.saveData(
          key: 'monitoringNotificationSingular',
          value: l10n.monitoringNotificationBody(1),
        );

        final pluralTemplate = l10n
            .monitoringNotificationBody(2)
            .replaceAll('2', '{count}');
        await FlutterForegroundTask.saveData(
          key: 'monitoringNotificationPlural',
          value: pluralTemplate,
        );
        await FlutterForegroundTask.saveData(
          key: 'alarmDismiss',
          value: l10n.alarmDismiss,
        );
      }
    }

    await FlutterForegroundTask.startService(
      notificationTitle: initialTitle,
      notificationText: initialText,
      callback: monitoringStartCallback,
    );
  }

  void dismissAlarm(int alarmId) {
    FlutterForegroundTask.sendDataToTask({
      'action': 'dismiss',
      'alarmId': alarmId,
    });
  }
}
