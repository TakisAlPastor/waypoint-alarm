import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RadiusCircleLayer extends StatelessWidget {
  const RadiusCircleLayer({required this.circles, super.key});

  final List<RadiusCircleData> circles;

  @override
  Widget build(BuildContext context) {
    if (circles.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return CircleLayer(
      circles: circles
          .map(
            (data) => CircleMarker(
              point: data.center,
              radius: data.radiusMeters,
              useRadiusInMeter: true,
              color: (data.isActive ? colorScheme.primary : colorScheme.outline)
                  .withValues(alpha: 0.15),
              borderColor: data.isActive
                  ? colorScheme.primary
                  : colorScheme.outline,
              borderStrokeWidth: 2,
            ),
          )
          .toList(),
    );
  }
}

class RadiusCircleData {
  const RadiusCircleData({
    required this.center,
    required this.radiusMeters,
    required this.isActive,
  });

  final LatLng center;
  final double radiusMeters;
  final bool isActive;
}
