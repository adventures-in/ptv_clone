import 'package:meta/meta.dart';
import 'package:ptv_api_client/api.dart';

import 'package:ptv_clone/utilities/credentials.dart';

class ApiService {
  ApiService(this.departuresApi, this.stopsApi, this.runsApi, this.routesApi) {
    defaultApiClient.setCredentials(credentials['key'], credentials['uid']);
  }

  final DeparturesApi departuresApi;
  final StopsApi stopsApi;
  final RunsApi runsApi;
  final RoutesApi routesApi;

  Future<V3StopsByDistanceResponse> getStopsByLocation(
          double latitude, double longitude) =>
      stopsApi.stopsStopsByGeolocation(-37.747650146484375, 145.07156175571774);

  Future<V3StopResponse> getStopDetails(
          {@required int stopId, @required int routeType}) =>
      stopsApi.stopsStopDetails(stopId, routeType);

  Future<V3DeparturesResponse> getDepartures(
          {@required int routeType, @required int stopId}) =>
      departuresApi.departuresGetForStop(routeType, stopId);

  Future<V3RoutesResponse> getRoutes() => routesApi.routesOneOrMoreRoutes();
}
