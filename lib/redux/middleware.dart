import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:ptv_clone/services/api_service.dart';
import 'package:ptv_clone/services/device_service.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddlewares(
    ApiService apiService, DeviceService deviceService) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, ActionRequestLocation>(
      _getLocation(deviceService),
    ),
  ];
}

void Function(Store<AppState> store, ActionRequestLocation action,
    NextDispatcher next) _getLocation(DeviceService deviceService) {
  return (Store<AppState> store, ActionRequestLocation action,
      NextDispatcher next) async {
    next(action);

    store.dispatch(await deviceService.requestLocationAction());
  };
}
