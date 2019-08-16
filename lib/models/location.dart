import 'package:quiver/core.dart';

class Location {
  Location({this.latitude, this.longitude, this.timestamp});

  /// The latitude of this position in degrees normalized to the interval -90.0 to +90.0 (both inclusive).
  final double latitude;

  /// The longitude of the position in degrees normalized to the interval -180 (exclusive) to +180 (inclusive).
  final double longitude;

  /// The time at which this position was determined.
  final DateTime timestamp;

  Location copyWith({double latitude, double longitude, DateTime timestamp}) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  int get hashCode => hash3(latitude, longitude, timestamp);

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          timestamp == other.timestamp;

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude, timestamp: $timestamp}';
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': timestamp,
      };
}
