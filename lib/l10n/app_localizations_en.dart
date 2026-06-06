// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Waypoint Alarm';

  @override
  String get navMap => 'Map';

  @override
  String get navAlarms => 'Alarms';

  @override
  String get navSettings => 'Settings';

  @override
  String get alarmsEmptyTitle => 'No alarms yet';

  @override
  String get alarmsEmptySubtitle => 'Tap the map to create your first alarm.';

  @override
  String get alarmsEmptyAction => 'Go to map';

  @override
  String get alarmActive => 'Active';

  @override
  String get alarmInactive => 'Inactive';

  @override
  String get alarmNameHint => 'e.g. My stop, Home, Work';

  @override
  String get alarmNameLabel => 'Alarm name';

  @override
  String get alarmRadiusLabel => 'Radius';

  @override
  String get alarmToneLabel => 'Alarm tone';

  @override
  String get alarmToneChoose => 'Choose audio';

  @override
  String get alarmToneDefault => 'Default tone';

  @override
  String get alarmVolumeLabel => 'Volume';

  @override
  String get alarmTriggerBehaviorLabel => 'When triggered';

  @override
  String get triggerAutoDeactivate => 'Auto deactivate';

  @override
  String get triggerManualDismiss => 'Manual dismiss';

  @override
  String get triggerSoundDuration => 'Sound for N seconds';

  @override
  String get alarmSave => 'Activate alarm';

  @override
  String get alarmCancel => 'Cancel';

  @override
  String get alarmEdit => 'Edit';

  @override
  String get alarmDelete => 'Delete';

  @override
  String get alarmDeleteConfirmTitle => 'Delete alarm';

  @override
  String alarmDeleteConfirmMessage(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get errorSearching => 'Error searching. Try again.';

  @override
  String get searchPlaceholder => 'Search for a place...';

  @override
  String get monitoringNotificationTitle => 'Waypoint Alarm';

  @override
  String monitoringNotificationBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarms monitoring your location',
      one: '1 alarm monitoring your location',
    );
    return '$_temp0';
  }

  @override
  String get monitoringPauseAll => 'Pause all';

  @override
  String get monitoringViewAlarms => 'View alarms';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageAuto => 'Automatic (system)';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeAuto => 'Automatic (system)';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsPrecisionMode => 'Location precision';

  @override
  String get settingsPrecisionGpsOnly => 'GPS only';

  @override
  String get settingsPrecisionGpsOnlyDesc =>
      'Lower battery usage, less accuracy indoors';

  @override
  String get settingsPrecisionHigh => 'High precision';

  @override
  String get settingsPrecisionHighDesc =>
      'GPS + WiFi + mobile data — best accuracy';

  @override
  String get settingsPrecisionLow => 'Battery saver';

  @override
  String get settingsPrecisionLowDesc =>
      'Lowest accuracy, minimal battery impact';

  @override
  String get settingsDefaultBehavior => 'Default trigger behavior';

  @override
  String get settingsPermissions => 'Permissions';

  @override
  String get settingsPermissionGranted => 'Granted';

  @override
  String get settingsPermissionDenied => 'Denied';

  @override
  String get settingsAdsTitle => 'Enable non-intrusive ads';

  @override
  String get settingsAdsSubtitle =>
      'Help support the developer with occasional banner ads';

  @override
  String get settingsDonateTitle => 'Buy me a coffee ☕';

  @override
  String get settingsDonateSubtitle =>
      'Support development via Ko-fi or PayPal';

  @override
  String get settingsAbout => 'About';

  @override
  String settingsVersion(String version) {
    return 'Version $version';
  }

  @override
  String get settingsLicenses => 'Open source licenses';

  @override
  String get settingsTutorial => 'View tutorial again';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingWelcomeTitle => 'Never miss your stop';

  @override
  String get onboardingWelcomeSubtitle =>
      'Waypoint Alarm alerts you when you\'re near your destination, so you can relax during your trip.';

  @override
  String get onboardingHowTitle => 'How it works';

  @override
  String get onboardingHowStep1 => 'Place a point on the map';

  @override
  String get onboardingHowStep2 => 'Set the radius';

  @override
  String get onboardingHowStep3 => 'The alarm goes off when you arrive';

  @override
  String get onboardingPermissionTitle => 'Location permission';

  @override
  String get onboardingPermissionSubtitle =>
      'We need your precise location to show where you are on the map and detect when you\'re near your destination.';

  @override
  String get onboardingPermissionGrant => 'Grant permission';

  @override
  String get onboardingReadyTitle => 'All set!';

  @override
  String get onboardingReadySubtitle =>
      'You\'re ready to create your first alarm.';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get permissionLocationTitle => 'Location';

  @override
  String get permissionBackgroundLocationTitle => 'Background location';

  @override
  String get permissionNotificationTitle => 'Notifications';

  @override
  String get permissionAudioTitle => 'Audio files';

  @override
  String get generalSection => 'General';

  @override
  String get locationSection => 'Location';

  @override
  String get alarmsSection => 'Alarms';

  @override
  String get monetizationSection => 'Monetization';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get unitMeters => 'm';

  @override
  String get unitPercent => '%';

  @override
  String get alertTriggeredTitle => 'You\'ve arrived!';

  @override
  String alertTriggeredBody(String name) {
    return 'You are near \"$name\"';
  }

  @override
  String get permissionLocationRationale =>
      'Location is needed to detect when you are near your alarms.';

  @override
  String get permissionBackgroundLocationRationale =>
      'Background location allows alarms to work even when the app is closed.';

  @override
  String get permissionNotificationRationale =>
      'Notifications let us alert you when you arrive at your destination.';

  @override
  String get permissionBatteryOptimizationTitle => 'Battery optimization';

  @override
  String get permissionBatteryOptimizationRationale =>
      'Disabling battery optimization ensures alarms work reliably in the background.';

  @override
  String get monitoringStarted => 'Monitoring started';

  @override
  String get monitoringStopped => 'Monitoring stopped';

  @override
  String get permissionDeniedMessage =>
      'Some permissions were denied. Alarms may not work correctly in the background.';

  @override
  String get alarmDismiss => 'Dismiss';
}
