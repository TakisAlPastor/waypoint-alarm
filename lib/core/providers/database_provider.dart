import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:waypoint_alarm/core/database/app_database.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}
