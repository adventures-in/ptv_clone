import 'package:ptv_api_client/api.dart';

import 'package:geolocator/geolocator.dart';

class ApiService {
  ApiService();

  Future<V3StopsByDistanceResponse> getStops() async {
    final api_instance = StopsApi();

    try {
      Position position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

      final V3StopsByDistanceResponse result = await api_instance
          .stopsStopsByGeolocation(position.latitude, position.longitude);
      return result;
    } catch (e) {
      print(
          "Exception when calling DisruptionsApi->disruptionsGetAllDisruptions: $e\n");
      return null;
    }
  }
}
