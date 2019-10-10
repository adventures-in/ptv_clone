import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:ptv_clone/models/location.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:ptv_clone/utilities/mocks.dart' as location;

class DeviceService {
  DeviceService(this._geolocator);

  final Geolocator _geolocator;

  /// get the current location using the geolocator package
  /// convert a [Geolocator.Position] to a [Location]
  Future<Action> requestLocationAction() async {
    // Position position = await _geolocator.getLastKnownPosition(
    // desiredAccuracy: LocationAccuracy.high);
    Position position = location.microsoft;

    return ActionStoreLocation(
      location: Location(
        (b) => b
          ..latitude = position.latitude
          ..longitude = position.longitude
          ..timestamp = position.timestamp.toUtc(),
      ),
    );
  }

  Stream<Action> get locationStream {
    return _geolocator.getPositionStream().map(
          (position) => ActionStoreLocation(
            location: Location(
              (b) => b
                ..latitude = position.latitude
                ..longitude = position.longitude
                ..timestamp = position.timestamp.toUtc(),
            ),
          ),
        );
  }
}
