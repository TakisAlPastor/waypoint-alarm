const String kTileUrlTemplate =
    'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

const String kMapUserAgent =
    'dev.alfredocamarena.waypoint_alarm/1.0 (alfredoccm@protonmail.com)';

const double kInitialZoom = 15;
const double kMinZoom = 3;
const double kMaxZoom = 18;

/// Nominatim enforces a max of 1 request per second.
const Duration kGeocodingThrottleDuration = Duration(seconds: 1);
const String kNominatimBaseUrl = 'https://nominatim.openstreetmap.org';

const Duration kMaxTileCacheStaleDuration = Duration(days: 30);
