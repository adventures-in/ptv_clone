import 'package:meta/meta.dart';
import 'package:ptv_api_client/api.dart';

import 'package:ptv_clone/utilities/credentials.dart';

class ApiService {
  ApiService(this.stopsApi, this.routesApi) {
    defaultApiClient.setCredentials(credentials['key'], credentials['uid']);
  }

  final stopsApi;
  final routesApi;

  Future<V3StopsByDistanceResponse> getStopsByLocation(
          double latitude, double longitude) =>
      stopsApi.stopsStopsByGeolocation(latitude, longitude);

  Future<V3RouteResponse> getRoutesFor({@required int id}) =>
      routesApi.routesRouteFromId(id);
}
