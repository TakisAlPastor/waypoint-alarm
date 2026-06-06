// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Waypoint Alarm';

  @override
  String get navMap => 'Mapa';

  @override
  String get navAlarms => 'Alarmas';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get alarmsEmptyTitle => 'No tienes alarmas todavía';

  @override
  String get alarmsEmptySubtitle =>
      'Toca el mapa para crear tu primera alarma.';

  @override
  String get alarmsEmptyAction => 'Ir al mapa';

  @override
  String get alarmActive => 'Activa';

  @override
  String get alarmInactive => 'Inactiva';

  @override
  String get alarmNameHint => 'Ej: Mi parada, Casa, Trabajo';

  @override
  String get alarmNameLabel => 'Nombre de la alarma';

  @override
  String get alarmRadiusLabel => 'Radio';

  @override
  String get alarmToneLabel => 'Tono de alarma';

  @override
  String get alarmToneChoose => 'Elegir audio';

  @override
  String get alarmToneDefault => 'Tono predeterminado';

  @override
  String get alarmVolumeLabel => 'Volumen';

  @override
  String get alarmTriggerBehaviorLabel => 'Al dispararse';

  @override
  String get triggerAutoDeactivate => 'Desactivar automáticamente';

  @override
  String get triggerManualDismiss => 'Apagar manualmente';

  @override
  String get triggerSoundDuration => 'Sonar N segundos';

  @override
  String get alarmSave => 'Activar alarma';

  @override
  String get alarmCancel => 'Cancelar';

  @override
  String get alarmEdit => 'Editar';

  @override
  String get alarmDelete => 'Eliminar';

  @override
  String get alarmDeleteConfirmTitle => 'Eliminar alarma';

  @override
  String alarmDeleteConfirmMessage(String name) {
    return '¿Estás seguro de que deseas eliminar \"$name\"?';
  }

  @override
  String get errorSearching => 'Error al buscar. Intenta de nuevo.';

  @override
  String get searchPlaceholder => 'Buscar un lugar...';

  @override
  String get monitoringNotificationTitle => 'Waypoint Alarm';

  @override
  String monitoringNotificationBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmas monitoreando tu ubicación',
      one: '1 alarma monitoreando tu ubicación',
    );
    return '$_temp0';
  }

  @override
  String get monitoringPauseAll => 'Pausar todas';

  @override
  String get monitoringViewAlarms => 'Ver alarmas';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageAuto => 'Automático (sistema)';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeAuto => 'Automático (sistema)';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsPrecisionMode => 'Precisión de ubicación';

  @override
  String get settingsPrecisionGpsOnly => 'Solo GPS';

  @override
  String get settingsPrecisionGpsOnlyDesc =>
      'Menor uso de batería, menos precisión en interiores';

  @override
  String get settingsPrecisionHigh => 'Alta precisión';

  @override
  String get settingsPrecisionHighDesc =>
      'GPS + WiFi + datos móviles — mejor precisión';

  @override
  String get settingsPrecisionLow => 'Bajo consumo';

  @override
  String get settingsPrecisionLowDesc =>
      'Menor precisión, mínimo impacto en batería';

  @override
  String get settingsDefaultBehavior =>
      'Comportamiento por defecto al dispararse';

  @override
  String get settingsPermissions => 'Permisos';

  @override
  String get settingsPermissionGranted => 'Concedido';

  @override
  String get settingsPermissionDenied => 'Denegado';

  @override
  String get settingsAdsTitle => 'Activar anuncios no intrusivos';

  @override
  String get settingsAdsSubtitle =>
      'Ayuda al desarrollador con anuncios de banner ocasionales';

  @override
  String get settingsDonateTitle => 'Invítame un café ☕';

  @override
  String get settingsDonateSubtitle => 'Apoya el desarrollo vía Ko-fi o PayPal';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String settingsVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get settingsLicenses => 'Licencias de código abierto';

  @override
  String get settingsTutorial => 'Ver tutorial de nuevo';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingWelcomeTitle => 'Nunca pierdas tu parada';

  @override
  String get onboardingWelcomeSubtitle =>
      'Waypoint Alarm te alerta cuando estés cerca de tu destino, para que puedas relajarte durante tu viaje.';

  @override
  String get onboardingHowTitle => 'Cómo funciona';

  @override
  String get onboardingHowStep1 => 'Pon un punto en el mapa';

  @override
  String get onboardingHowStep2 => 'Elige el radio';

  @override
  String get onboardingHowStep3 => 'La alarma suena al llegar';

  @override
  String get onboardingPermissionTitle => 'Permiso de ubicación';

  @override
  String get onboardingPermissionSubtitle =>
      'Necesitamos tu ubicación precisa para mostrar tu posición en el mapa y detectar cuando estés cerca de tu destino.';

  @override
  String get onboardingPermissionGrant => 'Conceder permiso';

  @override
  String get onboardingReadyTitle => '¡Todo listo!';

  @override
  String get onboardingReadySubtitle => 'Ya puedes crear tu primera alarma.';

  @override
  String get onboardingStart => 'Empezar';

  @override
  String get permissionLocationTitle => 'Ubicación';

  @override
  String get permissionBackgroundLocationTitle => 'Ubicación en segundo plano';

  @override
  String get permissionNotificationTitle => 'Notificaciones';

  @override
  String get permissionAudioTitle => 'Archivos de audio';

  @override
  String get generalSection => 'General';

  @override
  String get locationSection => 'Localización';

  @override
  String get alarmsSection => 'Alarmas';

  @override
  String get monetizationSection => 'Monetización';

  @override
  String get confirm => 'Confirmar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get unitMeters => 'm';

  @override
  String get unitPercent => '%';

  @override
  String get alertTriggeredTitle => '¡Has llegado!';

  @override
  String alertTriggeredBody(String name) {
    return 'Estás cerca de \"$name\"';
  }

  @override
  String get permissionLocationRationale =>
      'Se requiere ubicación para detectar cuándo estás cerca de tus alarmas.';

  @override
  String get permissionBackgroundLocationRationale =>
      'La ubicación en segundo plano permite que las alarmas funcionen incluso con la app cerrada.';

  @override
  String get permissionNotificationRationale =>
      'Las notificaciones nos permiten alertarte cuando llegues a tu destino.';

  @override
  String get permissionBatteryOptimizationTitle => 'Optimización de batería';

  @override
  String get permissionBatteryOptimizationRationale =>
      'Desactivar la optimización de batería asegura que las alarmas funcionen de forma confiable en segundo plano.';

  @override
  String get monitoringStarted => 'Monitoreo iniciado';

  @override
  String get monitoringStopped => 'Monitoreo detenido';

  @override
  String get permissionDeniedMessage =>
      'Se denegaron algunos permisos. Las alarmas podrían no funcionar correctamente en segundo plano.';

  @override
  String get alarmDismiss => 'Apagar';
}
