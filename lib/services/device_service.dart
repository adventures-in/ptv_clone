import 'package:geolocator/geolocator.dart';
import 'package:ptv_clone/models/location.dart';

class DeviceService {
  DeviceService(this._geolocator);

  final Geolocator _geolocator;

  /// get the current location using the geolocator package
  /// convert a [Geolocator.Position] to a [Location]
  Future<Location> getLocation() async {
    Position position = await _geolocator.getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);

    return Location(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: position.timestamp);
  }
}
