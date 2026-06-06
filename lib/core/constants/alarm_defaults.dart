const double kMinRadiusMeters = 500;
const double kMaxRadiusMeters = 5000;
const double kDefaultRadiusMeters = 500;

const int kDefaultVolumePercent = 80;
const int kMinVolumePercent = 0;
const int kMaxVolumePercent = 100;

const int kDefaultTriggerDurationSeconds = 30;
const Duration kDefaultTriggerDuration = Duration(
  seconds: kDefaultTriggerDurationSeconds,
);

const String kDefaultAlarmToneAsset = 'assets/audio/default_alarm.mp3';

const double kFarDistanceThresholdMeters = 5000;
const double kMediumDistanceThresholdMeters = 1000;
const Duration kFarPollingInterval = Duration(seconds: 30);
const Duration kMediumPollingInterval = Duration(seconds: 15);
const Duration kNearPollingInterval = Duration(seconds: 5);

const int kForegroundServiceId = 256;
const String kForegroundServiceChannelId = 'waypoint_alarm_monitoring';
const String kForegroundServiceChannelName = 'Location Monitoring';

const String kAlertNotificationChannelId = 'waypoint_alarm_alert';
const String kAlertNotificationChannelName = 'Alarm Alerts';
const int kAlertNotificationBaseId = 1000;
