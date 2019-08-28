import 'package:ptv_api_client/api.dart';

import 'package:ptv_clone/utilities/credentials.dart';

class ApiService {
  ApiService() {
    defaultApiClient.setCredentials(credentials['key'], credentials['uid']);
  }

  Future<V3StopsByDistanceResponse> getNearbyStops(
      double latitude, double longitude) async {
    final api_instance = StopsApi();

    try {
      final V3StopsByDistanceResponse result =
          await api_instance.stopsStopsByGeolocation(latitude, longitude);
      return result;
    } catch (e) {
      print(
          "Exception when calling DisruptionsApi->disruptionsGetAllDisruptions: $e\n");
      return null;
    }
  }
}
