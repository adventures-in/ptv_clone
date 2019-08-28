import 'package:ptv_clone/models/built_app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:ptv_clone/services/api_service.dart';
import 'package:ptv_clone/services/device_service.dart';
import 'package:redux/redux.dart';

List<Middleware<BuiltAppState>> createMiddlewares(
    ApiService apiService, DeviceService deviceService) {
  return <Middleware<BuiltAppState>>[
    TypedMiddleware<BuiltAppState, ActionObserveLocation>(
      _getLocation(deviceService),
    ),
  ];
}

void Function(Store<BuiltAppState> store, ActionObserveLocation action,
    NextDispatcher next) _getLocation(DeviceService deviceService) {
  return (Store<BuiltAppState> store, ActionObserveLocation action,
      NextDispatcher next) {
    next(action);

    deviceService.locationStream.listen(store.dispatch);
  };
}

// void Function(Store<BuiltAppState> store, ActionStoreLocation action,
//     NextDispatcher next) _getNearbyStops(ApiService apiService) {
//   return (Store<BuiltAppState> store, ActionStoreLocation action,
//       NextDispatcher next) async {
//     next(action);

//     var listFromApi = await apiService.getNearbyStops(action.latitude, action.longitude);

//     BuiltList<BuiltStopLocation> stops = BuiltList<BuiltStopLocation>()

//     // store.dispatch(ActionSetNearbyStops());
//   };
// }
