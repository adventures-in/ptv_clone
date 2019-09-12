import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_api_client/api/routes_api.dart';
import 'package:ptv_api_client/api/stops_api.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/middleware.dart';
import 'package:ptv_clone/redux/reducers.dart';
import 'package:ptv_clone/services/api_service.dart';
import 'package:ptv_clone/services/device_service.dart';
import 'package:ptv_clone/widgets/app.dart';
import 'package:redux/redux.dart';

void main() {
  final departuresApi = DeparturesApi();
  final directionsApi = DirectionsApi();
  final disruptionsApi = DisruptionsApi();
  final outletsApi = OutletsApi();
  final patternsApi = PatternsApi();
  final routesApi = RoutesApi();
  final routeTypesApi = RouteTypesApi();
  final runsApi = RunsApi();
  final searchApi = SearchApi();
  final stopsApi = StopsApi();

  final ApiService apiService = ApiService(
    departuresApi,
    directionsApi,
    disruptionsApi,
    outletsApi,
    patternsApi,
    routesApi,
    routeTypesApi,
    runsApi,
    searchApi,
    stopsApi,
  );

  final DeviceService deviceService = DeviceService(Geolocator());

  final store = Store<AppState>(
    appStateReducer,
    middleware: createMiddlewares(apiService, deviceService),
    initialState: AppState.initialState(),
  );

  runApp(MyApp(store));
}
