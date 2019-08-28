import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ptv_clone/models/built_app_state.dart';
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

  final ApiService apiService = ApiService();
  final DeviceService deviceService = DeviceService(Geolocator());

  final DevToolsStore store = DevToolsStore<BuiltAppState>(
    appStateReducer,
    middleware: [
      remoteDevtools,
      ...createMiddlewares(apiService, deviceService)
    ],
    initialState: BuiltAppState.initialState(),
  );

  remoteDevtools.store = store;

  runApp(MyApp(store));
}
