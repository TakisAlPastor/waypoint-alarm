import 'dart:io';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  PermissionHelper._();

  /// Requests the standard fine location permission.
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  /// Requests background location permission.
  /// This usually requires fine location to be granted first.
  static Future<bool> requestBackgroundLocationPermission() async {
    final status = await Permission.locationAlways.request();
    return status.isGranted;
  }

  /// Requests notification permissions.
  /// Required on Android 13+ and iOS.
  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// Requests audio permission.
  /// Required on Android 13+ to read local media files.
  static Future<bool> requestAudioPermission() async {
    // Media location/audio is only strictly needed if we are picking local audio files.
    // However, the foreground task handler itself might need basic permissions.
    if (Platform.isAndroid) {
      final status = await Permission.audio.request();
      return status.isGranted;
    }
    return true; // iOS doesn't need this specific permission for playing bundled/local audio in the same way.
  }

  /// Ensures that all mandatory permissions for monitoring are granted.
  static Future<bool> ensureMonitoringPermissions() async {
    if (!await Permission.notification.isGranted) {
      final notifGranted = await requestNotificationPermission();
      if (!notifGranted) return false;
    }

    if (!await Permission.location.isGranted) {
      final locGranted = await requestLocationPermission();
      if (!locGranted) return false;
    }

    if (!await Permission.locationAlways.isGranted) {
      final bgLocGranted = await requestBackgroundLocationPermission();
      if (!bgLocGranted) return false;
    }

    if (Platform.isAndroid) {
      final isIgnoring =
          await FlutterForegroundTask.isIgnoringBatteryOptimizations;
      if (!isIgnoring) {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }
    }

    return true;
  }
}
