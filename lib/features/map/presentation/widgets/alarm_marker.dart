import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AlarmMarkerLayer extends StatelessWidget {
  const AlarmMarkerLayer({required this.alarmMarkers, super.key});

  final List<AlarmMarkerData> alarmMarkers;

  @override
  Widget build(BuildContext context) {
    if (alarmMarkers.isEmpty) return const SizedBox.shrink();

    return MarkerLayer(
      markers: alarmMarkers.map(_buildMarker).toList(),
    );
  }

  Marker _buildMarker(AlarmMarkerData data) {
    return Marker(
      point: data.position,
      width: 120,
      height: 48,
      child: _AlarmMarkerWidget(
        label: data.label,
        isActive: data.isActive,
      ),
    );
  }
}

class _AlarmMarkerWidget extends StatelessWidget {
  const _AlarmMarkerWidget({
    required this.label,
    required this.isActive,
  });

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final markerColor = isActive ? colorScheme.primary : colorScheme.outline;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.location_on, color: markerColor, size: 28),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: markerColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimary,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

class AlarmMarkerData {
  const AlarmMarkerData({
    required this.position,
    required this.label,
    required this.isActive,
  });

  final LatLng position;
  final String label;
  final bool isActive;
}
