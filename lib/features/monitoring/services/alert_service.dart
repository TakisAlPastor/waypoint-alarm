import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:just_audio/just_audio.dart';
import 'package:waypoint_alarm/core/constants/alarm_defaults.dart';
import 'package:waypoint_alarm/core/database/app_database.dart';
import 'package:waypoint_alarm/core/database/daos/alarm_dao.dart';
import 'package:waypoint_alarm/features/alarm/domain/alarm_model.dart';

class AlertService {
  AlertService(this.db) {
    _alarmDao = AlarmDao(db);
    unawaited(_initNotifications());
  }

  final AppDatabase db;
  late final AlarmDao _alarmDao;

  int? _playingAlarmId;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _initNotifications() async {
    final session = await AudioSession.instance;
    await session.configure(
      const AudioSessionConfiguration(
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.sonification,
          usage: AndroidAudioUsage.alarm,
        ),
      ),
    );

    const androidChannel = AndroidNotificationChannel(
      kAlertNotificationChannelId,
      kAlertNotificationChannelName,
      importance: Importance.max,
    );

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(androidChannel);
    }

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _notificationsPlugin.initialize(settings: initSettings);
  }

  Future<void> triggerAlert(AlarmModel alarm) async {
    if (alarm.id == null) return;

    await Haptics.vibrate(HapticsType.heavy);

    if (_playingAlarmId == null) {
      _playingAlarmId = alarm.id;

      await _audioPlayer.setVolume(alarm.volumePercent / 100.0);

      if (alarm.triggerBehavior == AlarmTriggerBehavior.dismissible) {
        await _audioPlayer.setLoopMode(LoopMode.one);
      } else {
        await _audioPlayer.setLoopMode(LoopMode.off);
      }

      try {
        if (alarm.audioFilePath != null && alarm.audioFilePath!.isNotEmpty) {
          await _audioPlayer.setFilePath(alarm.audioFilePath!);
        } else {
          await _audioPlayer.setAsset(kDefaultAlarmToneAsset);
        }
        await _audioPlayer.play();
      } on PlayerException {
        await _audioPlayer.setAsset(kDefaultAlarmToneAsset);
        await _audioPlayer.play();
      }
    }

    final dismissText =
        await FlutterForegroundTask.getData<String>(
          key: 'alarmDismiss',
        ) ??
        'Dismiss';

    final androidDetails = AndroidNotificationDetails(
      kAlertNotificationChannelId,
      kAlertNotificationChannelName,
      importance: Importance.max,
      priority: Priority.high,
      category: AndroidNotificationCategory.alarm,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'dismiss_${alarm.id}',
          dismissText,
          showsUserInterface: true,
        ),
      ],
    );

    final details = NotificationDetails(
      android: androidDetails,
    );

    final title = await FlutterForegroundTask.getData<String>(
      key: 'alertTriggeredTitle',
    );

    final bodyTemplate = await FlutterForegroundTask.getData<String>(
      key: 'alertTriggeredBody',
    );
    final body = bodyTemplate?.replaceAll('{name}', alarm.name);

    await _notificationsPlugin.show(
      id: kAlertNotificationBaseId + alarm.id!,
      title: title,
      body: body,
      notificationDetails: details,
    );

    await _handlePostTriggerBehavior(alarm);
  }

  Future<void> _handlePostTriggerBehavior(AlarmModel alarm) async {
    if (alarm.triggerBehavior == AlarmTriggerBehavior.oneTime) {
      Future.delayed(alarm.triggerDurationSeconds, () async {
        await dismissAlert(alarm.id!);
        await _alarmDao.toggleAlarmActive(alarm.id!, isActive: false);
      });
    }
  }

  Future<void> dismissAlert(int alarmId) async {
    if (_playingAlarmId == alarmId) {
      await _audioPlayer.stop();
      _playingAlarmId = null;
    }
    await _notificationsPlugin.cancel(id: kAlertNotificationBaseId + alarmId);
  }

  void dispose() {
    unawaited(_audioPlayer.dispose());
  }
}
