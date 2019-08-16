import 'package:geolocator/geolocator.dart';
import 'package:ptv_clone/redux/actions.dart';

class DeviceService {
  DeviceService(this._geolocator);

  final Geolocator _geolocator;

  /// get the current location using the geolocator package
  /// convert a [Geolocator.Position] to a [Location]
  Future<ActionStoreLocation> requestLocationAction() async {
    Position position = await _geolocator.getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);

    return ActionStoreLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: position.timestamp);
  }
}
