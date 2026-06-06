import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Waypoint Alarm'**
  String get appTitle;

  /// No description provided for @navMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navMap;

  /// No description provided for @navAlarms.
  ///
  /// In en, this message translates to:
  /// **'Alarms'**
  String get navAlarms;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @alarmsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No alarms yet'**
  String get alarmsEmptyTitle;

  /// No description provided for @alarmsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the map to create your first alarm.'**
  String get alarmsEmptySubtitle;

  /// No description provided for @alarmsEmptyAction.
  ///
  /// In en, this message translates to:
  /// **'Go to map'**
  String get alarmsEmptyAction;

  /// No description provided for @alarmActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get alarmActive;

  /// No description provided for @alarmInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get alarmInactive;

  /// No description provided for @alarmNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. My stop, Home, Work'**
  String get alarmNameHint;

  /// No description provided for @alarmNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Alarm name'**
  String get alarmNameLabel;

  /// No description provided for @alarmRadiusLabel.
  ///
  /// In en, this message translates to:
  /// **'Radius'**
  String get alarmRadiusLabel;

  /// No description provided for @alarmToneLabel.
  ///
  /// In en, this message translates to:
  /// **'Alarm tone'**
  String get alarmToneLabel;

  /// No description provided for @alarmToneChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose audio'**
  String get alarmToneChoose;

  /// No description provided for @alarmToneDefault.
  ///
  /// In en, this message translates to:
  /// **'Default tone'**
  String get alarmToneDefault;

  /// No description provided for @alarmVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get alarmVolumeLabel;

  /// No description provided for @alarmTriggerBehaviorLabel.
  ///
  /// In en, this message translates to:
  /// **'When triggered'**
  String get alarmTriggerBehaviorLabel;

  /// No description provided for @triggerAutoDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Auto deactivate'**
  String get triggerAutoDeactivate;

  /// No description provided for @triggerManualDismiss.
  ///
  /// In en, this message translates to:
  /// **'Manual dismiss'**
  String get triggerManualDismiss;

  /// No description provided for @triggerSoundDuration.
  ///
  /// In en, this message translates to:
  /// **'Sound for N seconds'**
  String get triggerSoundDuration;

  /// No description provided for @alarmSave.
  ///
  /// In en, this message translates to:
  /// **'Activate alarm'**
  String get alarmSave;

  /// No description provided for @alarmCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get alarmCancel;

  /// No description provided for @alarmEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get alarmEdit;

  /// No description provided for @alarmDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get alarmDelete;

  /// No description provided for @alarmDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete alarm'**
  String get alarmDeleteConfirmTitle;

  /// No description provided for @alarmDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String alarmDeleteConfirmMessage(String name);

  /// No description provided for @errorSearching.
  ///
  /// In en, this message translates to:
  /// **'Error searching. Try again.'**
  String get errorSearching;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search for a place...'**
  String get searchPlaceholder;

  /// No description provided for @monitoringNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Waypoint Alarm'**
  String get monitoringNotificationTitle;

  /// No description provided for @monitoringNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 alarm monitoring your location} other{{count} alarms monitoring your location}}'**
  String monitoringNotificationBody(int count);

  /// No description provided for @monitoringPauseAll.
  ///
  /// In en, this message translates to:
  /// **'Pause all'**
  String get monitoringPauseAll;

  /// No description provided for @monitoringViewAlarms.
  ///
  /// In en, this message translates to:
  /// **'View alarms'**
  String get monitoringViewAlarms;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageAuto.
  ///
  /// In en, this message translates to:
  /// **'Automatic (system)'**
  String get settingsLanguageAuto;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeAuto.
  ///
  /// In en, this message translates to:
  /// **'Automatic (system)'**
  String get settingsThemeAuto;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsPrecisionMode.
  ///
  /// In en, this message translates to:
  /// **'Location precision'**
  String get settingsPrecisionMode;

  /// No description provided for @settingsPrecisionGpsOnly.
  ///
  /// In en, this message translates to:
  /// **'GPS only'**
  String get settingsPrecisionGpsOnly;

  /// No description provided for @settingsPrecisionGpsOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Lower battery usage, less accuracy indoors'**
  String get settingsPrecisionGpsOnlyDesc;

  /// No description provided for @settingsPrecisionHigh.
  ///
  /// In en, this message translates to:
  /// **'High precision'**
  String get settingsPrecisionHigh;

  /// No description provided for @settingsPrecisionHighDesc.
  ///
  /// In en, this message translates to:
  /// **'GPS + WiFi + mobile data — best accuracy'**
  String get settingsPrecisionHighDesc;

  /// No description provided for @settingsPrecisionLow.
  ///
  /// In en, this message translates to:
  /// **'Battery saver'**
  String get settingsPrecisionLow;

  /// No description provided for @settingsPrecisionLowDesc.
  ///
  /// In en, this message translates to:
  /// **'Lowest accuracy, minimal battery impact'**
  String get settingsPrecisionLowDesc;

  /// No description provided for @settingsDefaultBehavior.
  ///
  /// In en, this message translates to:
  /// **'Default trigger behavior'**
  String get settingsDefaultBehavior;

  /// No description provided for @settingsPermissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get settingsPermissions;

  /// No description provided for @settingsPermissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Granted'**
  String get settingsPermissionGranted;

  /// No description provided for @settingsPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get settingsPermissionDenied;

  /// No description provided for @settingsAdsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable non-intrusive ads'**
  String get settingsAdsTitle;

  /// No description provided for @settingsAdsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help support the developer with occasional banner ads'**
  String get settingsAdsSubtitle;

  /// No description provided for @settingsDonateTitle.
  ///
  /// In en, this message translates to:
  /// **'Buy me a coffee ☕'**
  String get settingsDonateTitle;

  /// No description provided for @settingsDonateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Support development via Ko-fi or PayPal'**
  String get settingsDonateSubtitle;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(String version);

  /// No description provided for @settingsLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open source licenses'**
  String get settingsLicenses;

  /// No description provided for @settingsTutorial.
  ///
  /// In en, this message translates to:
  /// **'View tutorial again'**
  String get settingsTutorial;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Never miss your stop'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Waypoint Alarm alerts you when you\'re near your destination, so you can relax during your trip.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingHowTitle.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get onboardingHowTitle;

  /// No description provided for @onboardingHowStep1.
  ///
  /// In en, this message translates to:
  /// **'Place a point on the map'**
  String get onboardingHowStep1;

  /// No description provided for @onboardingHowStep2.
  ///
  /// In en, this message translates to:
  /// **'Set the radius'**
  String get onboardingHowStep2;

  /// No description provided for @onboardingHowStep3.
  ///
  /// In en, this message translates to:
  /// **'The alarm goes off when you arrive'**
  String get onboardingHowStep3;

  /// No description provided for @onboardingPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Location permission'**
  String get onboardingPermissionTitle;

  /// No description provided for @onboardingPermissionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We need your precise location to show where you are on the map and detect when you\'re near your destination.'**
  String get onboardingPermissionSubtitle;

  /// No description provided for @onboardingPermissionGrant.
  ///
  /// In en, this message translates to:
  /// **'Grant permission'**
  String get onboardingPermissionGrant;

  /// No description provided for @onboardingReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'All set!'**
  String get onboardingReadyTitle;

  /// No description provided for @onboardingReadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re ready to create your first alarm.'**
  String get onboardingReadySubtitle;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingStart;

  /// No description provided for @permissionLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get permissionLocationTitle;

  /// No description provided for @permissionBackgroundLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Background location'**
  String get permissionBackgroundLocationTitle;

  /// No description provided for @permissionNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get permissionNotificationTitle;

  /// No description provided for @permissionAudioTitle.
  ///
  /// In en, this message translates to:
  /// **'Audio files'**
  String get permissionAudioTitle;

  /// No description provided for @generalSection.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalSection;

  /// No description provided for @locationSection.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationSection;

  /// No description provided for @alarmsSection.
  ///
  /// In en, this message translates to:
  /// **'Alarms'**
  String get alarmsSection;

  /// No description provided for @monetizationSection.
  ///
  /// In en, this message translates to:
  /// **'Monetization'**
  String get monetizationSection;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @unitMeters.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get unitMeters;

  /// No description provided for @unitPercent.
  ///
  /// In en, this message translates to:
  /// **'%'**
  String get unitPercent;

  /// No description provided for @alertTriggeredTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'ve arrived!'**
  String get alertTriggeredTitle;

  /// No description provided for @alertTriggeredBody.
  ///
  /// In en, this message translates to:
  /// **'You are near \"{name}\"'**
  String alertTriggeredBody(String name);

  /// No description provided for @permissionLocationRationale.
  ///
  /// In en, this message translates to:
  /// **'Location is needed to detect when you are near your alarms.'**
  String get permissionLocationRationale;

  /// No description provided for @permissionBackgroundLocationRationale.
  ///
  /// In en, this message translates to:
  /// **'Background location allows alarms to work even when the app is closed.'**
  String get permissionBackgroundLocationRationale;

  /// No description provided for @permissionNotificationRationale.
  ///
  /// In en, this message translates to:
  /// **'Notifications let us alert you when you arrive at your destination.'**
  String get permissionNotificationRationale;

  /// No description provided for @permissionBatteryOptimizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Battery optimization'**
  String get permissionBatteryOptimizationTitle;

  /// No description provided for @permissionBatteryOptimizationRationale.
  ///
  /// In en, this message translates to:
  /// **'Disabling battery optimization ensures alarms work reliably in the background.'**
  String get permissionBatteryOptimizationRationale;

  /// No description provided for @monitoringStarted.
  ///
  /// In en, this message translates to:
  /// **'Monitoring started'**
  String get monitoringStarted;

  /// No description provided for @monitoringStopped.
  ///
  /// In en, this message translates to:
  /// **'Monitoring stopped'**
  String get monitoringStopped;

  /// No description provided for @permissionDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Some permissions were denied. Alarms may not work correctly in the background.'**
  String get permissionDeniedMessage;

  /// No description provided for @alarmDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get alarmDismiss;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
