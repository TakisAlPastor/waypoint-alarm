import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:waypoint_alarm/core/database/daos/alarm_dao.dart';
import 'package:waypoint_alarm/core/database/tables/alarms.dart';
import 'package:waypoint_alarm/features/alarm/domain/alarm_model.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Alarms], daos: [AlarmDao])
class AppDatabase extends _$AppDatabase {
  factory AppDatabase() {
    _instance ??= AppDatabase._();
    return _instance!;
  }
  AppDatabase._([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  static AppDatabase? _instance;

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      return driftDatabase(
        name: 'database',
        native: const DriftNativeOptions(
          databaseDirectory: getApplicationSupportDirectory,
        ),
      );
    });
  }
}
