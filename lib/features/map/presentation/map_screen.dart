import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_cache_file_store/http_cache_file_store.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waypoint_alarm/core/constants/alarm_defaults.dart';
import 'package:waypoint_alarm/core/constants/map_defaults.dart';
import 'package:waypoint_alarm/features/alarm/presentation/widgets/alarm_bottom_sheet.dart';
import 'package:waypoint_alarm/features/alarm/providers/alarm_list_provider.dart';
import 'package:waypoint_alarm/features/map/presentation/widgets/alarm_marker.dart';
import 'package:waypoint_alarm/features/map/presentation/widgets/radius_circle.dart';
import 'package:waypoint_alarm/features/map/presentation/widgets/search_bar_widget.dart';
import 'package:waypoint_alarm/features/map/providers/map_state_provider.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  late final Future<CacheStore> _cacheStoreFuture;

  @override
  void initState() {
    super.initState();
    _cacheStoreFuture = _getCacheStore();
  }

  static Future<CacheStore> _getCacheStore() async {
    final dir = await getTemporaryDirectory();
    return FileCacheStore('${dir.path}${Platform.pathSeparator}MapTiles');
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPosition = ref.watch(selectedPositionProvider);
    final alarmsAsync = ref.watch(alarmListProvider);
    final alarms = alarmsAsync.value ?? [];

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(
                19.4326,
                -99.1332,
              ), // Mexico City (Test coordinates)
              // Kept explicit: app constant, not coincidental match.
              initialZoom: kInitialZoom,
              minZoom: kMinZoom,
              maxZoom: kMaxZoom,
              onTap: (_, latLng) {
                ref.read(selectedPositionProvider.notifier).position = latLng;
              },
            ),
            children: [
              FutureBuilder<CacheStore>(
                future: _cacheStoreFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return TileLayer(
                      urlTemplate: kTileUrlTemplate,
                      userAgentPackageName: kMapUserAgent,
                      retinaMode: RetinaMode.isHighDensity(context),
                      tileProvider: CachedTileProvider(
                        store: snapshot.data!,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              // const CurrentLocationLayer(), // Phase 4: Enable after implementing permission requests
              RadiusCircleLayer(
                circles: [
                  ...alarms.map(
                    (a) => RadiusCircleData(
                      center: LatLng(
                        a.latitude,
                        a.longitude,
                      ),
                      radiusMeters: a.radiusMeters,
                      isActive: a.isActive,
                    ),
                  ),
                  if (selectedPosition != null)
                    RadiusCircleData(
                      center: selectedPosition,
                      radiusMeters: kDefaultRadiusMeters,
                      isActive: true,
                    ),
                ],
              ),
              AlarmMarkerLayer(
                alarmMarkers: alarms
                    .map(
                      (a) => AlarmMarkerData(
                        position: LatLng(
                          a.latitude,
                          a.longitude,
                        ),
                        label: a.name,
                        isActive: a.isActive,
                      ),
                    )
                    .toList(),
              ),
              if (selectedPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedPosition,
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.add_location_alt,
                        color: Theme.of(context).colorScheme.primary,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(
                      Uri.parse('https://www.openstreetmap.org/copyright'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: MapSearchBar(
                onResultSelected: (result) {
                  final latLng = LatLng(result.latitude, result.longitude);
                  ref.read(selectedPositionProvider.notifier).position = latLng;
                  _mapController.move(latLng, kInitialZoom);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'centerLocation',
            onPressed: () {
              // Will be implemented with geolocator in Phase 4
            },
            child: const Icon(Icons.my_location),
          ),
          if (selectedPosition != null) ...[
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'createAlarm',
              onPressed: () {
                showAlarmBottomSheet(
                  context,
                  coordinates: selectedPosition,
                ).ignore();
              },
              child: const Icon(Icons.add_alert),
            ),
            const SizedBox(height: 8),
            FloatingActionButton.small(
              heroTag: 'clearSelection',
              onPressed: () =>
                  ref.read(selectedPositionProvider.notifier).clear(),
              child: const Icon(Icons.close),
            ),
          ],
        ],
      ),
    );
  }
}
