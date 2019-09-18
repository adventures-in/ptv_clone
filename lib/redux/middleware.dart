import 'package:built_collection/built_collection.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_api_client/api/directions_api.dart';
import 'package:ptv_api_client/model/v3_departure.dart';
import 'package:ptv_api_client/model/v3_direction.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/models/stop_departures_view_model.dart';
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

void Function(Store<AppState> store, ActionGetStopDepartures action,
    NextDispatcher next) _getStopDepartures(ApiService apiService) {
  return (Store<AppState> store, ActionGetStopDepartures action,
      NextDispatcher next) async {
    next(action);

    var response = await apiService.getDeparturesForStop(
        stopId: action.stopId, routeType: action.routeType);

    final departuresByCategory = Map<DepartureCategory, List<V3Departure>>();
    for (V3Departure departure in response.departures) {
      final category =
          DepartureCategory(departure.routeId, departure.directionId);
      // store all departures against the routeId, in order
      departuresByCategory[category] ??= List<V3Departure>();
      departuresByCategory[category].add(departure);
    }

    final routeIdsList = List<int>();
    final routeIdsSet = Set<int>();
    final nextDepartures = Map<DepartureCategory, V3Departure>();
    final nowUtc = DateTime.now().toUtc();
    final nextDepartureTimeStrings = Map<DepartureCategory, String>();
    final directionNames = Map<DepartureCategory, String>();
    for (DepartureCategory category in departuresByCategory.keys) {
      routeIdsList.add(category.routeId);
      routeIdsSet.add(category.routeId);
      // TODO: try departuresGetForStopAndRoute and see if we get estimated departure time
      // TODO: try getDirections

      // determine the next departure
      nextDepartures[category] = departuresByCategory[category].firstWhere(
          (departure) => departure.scheduledDepartureUtc.isAfter(nowUtc),
          orElse: () => departuresByCategory[category].first);
      // convert time to strings for the UI
      final DateTime scheduledLocalTime =
          nextDepartures[category].scheduledDepartureUtc.toLocal();
      final amPm = (scheduledLocalTime.hour < 12) ? 'AM' : 'PM';
      String timeString =
          '${scheduledLocalTime.hour % 12}:${scheduledLocalTime.minute} $amPm';
      nextDepartureTimeStrings[category] = timeString;
    }

    for (int routeId in routeIdsSet) {
      final response = await apiService.getDirectionsForRoute(routeId: routeId);
      for (V3DirectionWithDescription direction in response.directions) {
        final category =
            DepartureCategory(direction.routeId, direction.directionId);
        directionNames[category] = direction.directionName;
      }
    }

    // Create a BuiltList from each List for the viewmodels nested BuiltList
    final listOfDepartureLists = List<BuiltList<V3Departure>>();
    for (List<V3Departure> list in departuresByCategory.values) {
      listOfDepartureLists.add(BuiltList<V3Departure>(list));
    }

    final viewmodel = StopDeparturesViewModel(
      (b) => b
        ..departuresResponse = response.toBuilder()
        ..numDepartures = departuresByCategory.keys.length
        ..routeIds = ListBuilder<int>(routeIdsList)
        ..todaysDepartures =
            ListBuilder<BuiltList<V3Departure>>(listOfDepartureLists)
        ..directionNames = ListBuilder<String>(directionNames.values)
        ..nextDepartures = ListBuilder<V3Departure>(nextDepartures.values)
        ..timeStrings = ListBuilder<String>(nextDepartureTimeStrings.values),
    );

    store.dispatch(ActionStoreStopDepartures(viewmodel: viewmodel));
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
