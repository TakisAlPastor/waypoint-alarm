import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_state_provider.g.dart';

@riverpod
class SelectedPosition extends _$SelectedPosition {
  @override
  LatLng? build() => null;

  LatLng? get position => state;

  set position(LatLng? value) {
    state = value;
  }

  void clear() {
    state = null;
  }
}
