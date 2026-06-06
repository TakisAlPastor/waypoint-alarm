import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waypoint_alarm/core/constants/map_defaults.dart';

class GeocodingResult {
  const GeocodingResult({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });

  factory GeocodingResult.fromJson(Map<String, dynamic> json) {
    return GeocodingResult(
      displayName: json['display_name'] as String,
      latitude: double.parse(json['lat'] as String),
      longitude: double.parse(json['lon'] as String),
    );
  }

  final String displayName;
  final double latitude;
  final double longitude;
}

class GeocodingRepository {
  GeocodingRepository({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  DateTime? _lastRequestTime;

  Future<List<GeocodingResult>> search(String query) async {
    if (query.trim().isEmpty) return [];

    await _enforceThrottle();

    final uri = Uri.parse(kNominatimBaseUrl).replace(
      path: '/search',
      queryParameters: {
        'q': query,
        'format': 'jsonv2',
        'limit': '5',
      },
    );

    try {
      final response = await _httpClient
          .get(
            uri,
            headers: {'User-Agent': kMapUserAgent},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to fetch from Nominatim: ${response.statusCode}',
        );
      }

      final decoded = jsonDecode(response.body) as List<dynamic>;
      return decoded
          .cast<Map<String, dynamic>>()
          .map(GeocodingResult.fromJson)
          .toList();
    } catch (e) {
      throw Exception('Search request failed: $e');
    }
  }

  /// Nominatim usage policy: max 1 request per second.
  Future<void> _enforceThrottle() async {
    if (_lastRequestTime != null) {
      final elapsed = DateTime.now().difference(_lastRequestTime!);
      if (elapsed < kGeocodingThrottleDuration) {
        await Future<void>.delayed(kGeocodingThrottleDuration - elapsed);
      }
    }
    _lastRequestTime = DateTime.now();
  }

  void dispose() {
    _httpClient.close();
  }
}
