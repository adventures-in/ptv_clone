import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:ptv_clone/services/api_service.dart';
import 'package:ptv_clone/services/device_service.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddlewares(
    ApiService apiService, DeviceService deviceService) {
  return <Middleware<AppState>>[
    TypedMiddleware<AppState, ActionObserveLocation>(
      _getLocation(deviceService),
    ),
    TypedMiddleware<AppState, ActionGetRoutes>(
      _getRoutes(apiService),
    ),
    TypedMiddleware<AppState, ActionStoreLocation>(
      _getStopsByLocation(apiService),
    ),
    TypedMiddleware<AppState, ActionGetStopDetails>(
      _getStopDetails(apiService),
    ),
    TypedMiddleware<AppState, ActionGetStopDepartures>(
      _getStopDepartures(apiService),
    ),
  ];
}

void Function(Store<AppState> store, ActionObserveLocation action,
    NextDispatcher next) _getLocation(DeviceService deviceService) {
  return (Store<AppState> store, ActionObserveLocation action,
      NextDispatcher next) async {
    next(action);

    // deviceService.locationStream.listen(store.dispatch);

    Action locationAction = await deviceService.requestLocationAction();

    store.dispatch(locationAction);
  };
}

void Function(
        Store<AppState> store, ActionGetRoutes action, NextDispatcher next)
    _getRoutes(ApiService apiService) {
  return (Store<AppState> store, ActionGetRoutes action,
      NextDispatcher next) async {
    next(action);

    var routesResponse = await apiService.getRoutes();

    store.dispatch(ActionStoreRoutes(response: routesResponse));
  };
}

void Function(
        Store<AppState> store, ActionStoreLocation action, NextDispatcher next)
    _getStopsByLocation(ApiService apiService) {
  return (Store<AppState> store, ActionStoreLocation action,
      NextDispatcher next) async {
    next(action);

    var nearbyStopsResponse = await apiService.getStopsByGeolocation(
        latitude: action.location.latitude,
        longitude: action.location.longitude);

    store.dispatch(ActionStoreNearbyStops(nearbyStops: nearbyStopsResponse));
  };
}

void Function(
        Store<AppState> store, ActionGetStopDetails action, NextDispatcher next)
    _getStopDetails(ApiService apiService) {
  return (Store<AppState> store, ActionGetStopDetails action,
      NextDispatcher next) async {
    next(action);

    var stopDetailsResponse = await apiService.getStopDetails(
        stopId: action.stopId, routeType: action.routeType);

    store.dispatch(ActionStoreStopDetails(response: stopDetailsResponse));
  };
}

void Function(Store<AppState> store, ActionGetStopDepartures action,
    NextDispatcher next) _getStopDepartures(ApiService apiService) {
  return (Store<AppState> store, ActionGetStopDepartures action,
      NextDispatcher next) async {
    next(action);

    var response = await apiService.getDeparturesForStop(
        stopId: action.stopId,
        routeType: action.routeType,
        maxResults: 1,
        expand: ['1', '2', '3', '4', '5']);

    store.dispatch(
        ActionStoreStopDepartures(stopId: action.stopId, response: response));
  };
}
