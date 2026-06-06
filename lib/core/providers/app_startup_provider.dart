import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:waypoint_alarm/core/providers/database_provider.dart';

part 'app_startup_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  ref.watch(appDatabaseProvider);
}
