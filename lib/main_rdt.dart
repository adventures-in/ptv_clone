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
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';

void main() async {
  final RemoteDevToolsMiddleware remoteDevtools =
      RemoteDevToolsMiddleware('192.168.0.18:8000');
  await remoteDevtools.connect();

  final departuresApi = DeparturesApi();
  final stopsApi = StopsApi();
  final routesApi = RoutesApi();
  final runsApi = RunsApi();
  final ApiService apiService =
      ApiService(departuresApi, stopsApi, runsApi, routesApi);
  final DeviceService deviceService = DeviceService(Geolocator());

  final store = DevToolsStore<AppState>(
    appStateReducer,
    middleware: [
      remoteDevtools,
      ...createMiddlewares(apiService, deviceService)
    ],
    initialState: AppState.initialState(),
  );

  remoteDevtools.store = store;

  runApp(MyApp(store));
}
