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
  final stopsApi = StopsApi();
  final routesApi = RoutesApi();
  final runsApi = RunsApi();
  final ApiService apiService =
      ApiService(departuresApi, stopsApi, runsApi, routesApi);
  final DeviceService deviceService = DeviceService(Geolocator());

  final Store store = Store<AppState>(
    appStateReducer,
    middleware: createMiddlewares(apiService, deviceService),
    initialState: AppState.initialState(),
  );

  runApp(MyApp(store));
}
