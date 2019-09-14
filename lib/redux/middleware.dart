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
    TypedMiddleware<AppState, ActionGetDepartures>(
      _getDepartures(apiService),
    ),
    TypedMiddleware<AppState, ActionGetDeparturesForRoute>(
      _getDeparturesForRoute(apiService),
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

void Function(
        Store<AppState> store, ActionGetDepartures action, NextDispatcher next)
    _getDepartures(ApiService apiService) {
  return (Store<AppState> store, ActionGetDepartures action,
      NextDispatcher next) async {
    next(action);

    var departuresResponse = await apiService.getDeparturesForStop(
        stopId: action.stopId, routeType: action.routeType);

    store.dispatch(ActionStoreDepartures(response: departuresResponse));
  };
}

void Function(Store<AppState> store, ActionGetDeparturesForRoute action,
    NextDispatcher next) _getDeparturesForRoute(ApiService apiService) {
  return (Store<AppState> store, ActionGetDeparturesForRoute action,
      NextDispatcher next) async {
    next(action);

    var departuresResponse = await apiService.getDeparturesForStopAndRoute(
        routeType: action.routeType,
        stopId: action.stopId,
        routeId: action.routeId);

    store.dispatch(ActionStoreDeparturesForRoute(response: departuresResponse));
  };
}

void Function(
        Store<AppState> store, ActionGetDirections action, NextDispatcher next)
    _getDirections(ApiService apiService) {
  return (Store<AppState> store, ActionGetDirections action,
      NextDispatcher next) async {
    next(action);

    var directionsResponse =
        await apiService.getDirectionsForRoute(routeId: action.routeId);

    store.dispatch(ActionStoreDirections(response: directionsResponse));
  };
}
