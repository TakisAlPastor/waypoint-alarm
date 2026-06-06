import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:waypoint_alarm/features/map/data/geocoding_repository.dart';

part 'geocoding_provider.g.dart';

@Riverpod(keepAlive: true)
GeocodingRepository geocodingRepository(Ref ref) {
  final repository = GeocodingRepository();
  ref.onDispose(repository.dispose);
  return repository;
}

@riverpod
Future<List<GeocodingResult>> geocodingSearch(
  Ref ref,
  String query,
) async {
  if (query.trim().length < 3) return [];

  final repository = ref.watch(geocodingRepositoryProvider);

  var didDispose = false;
  ref.onDispose(() => didDispose = true);

  await Future<void>.delayed(const Duration(milliseconds: 500));

  if (didDispose) return [];

  return repository.search(query);
}
