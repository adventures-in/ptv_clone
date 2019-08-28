import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ptv_clone/models/built_app_state.dart';
import 'package:ptv_clone/redux/middleware.dart';
import 'package:ptv_clone/redux/reducers.dart';
import 'package:ptv_clone/services/api_service.dart';
import 'package:ptv_clone/services/device_service.dart';
import 'package:ptv_clone/widgets/app.dart';
import 'package:redux/redux.dart';

void main() {
  final ApiService apiService = ApiService();
  final DeviceService deviceService = DeviceService(Geolocator());

  final Store store = Store<BuiltAppState>(
    appStateReducer,
    middleware: createMiddlewares(apiService, deviceService),
    initialState: BuiltAppState.initialState(),
  );

  runApp(MyApp(store));
}
