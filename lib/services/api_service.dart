import 'package:ptv_api_client/api.dart';

import 'package:ptv_clone/utilities/credentials.dart';

class ApiService {
  ApiService() {
    defaultApiClient.setCredentials(credentials['key'], credentials['uid']);
  }

  final stopsApi = StopsApi();

  Future<V3StopsByDistanceResponse> getStopsByLocation(
      double latitude, double longitude) async {
    try {
      final V3StopsByDistanceResponse result =
          await stopsApi.stopsStopsByGeolocation(latitude, longitude);
      return result;
    } catch (e) {
      print(
          "Exception when calling DisruptionsApi->disruptionsGetAllDisruptions: $e\n");
      return null;
    }
  }
}
