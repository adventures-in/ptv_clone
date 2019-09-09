import 'package:built_collection/built_collection.dart';
import 'package:ptv_api_client/model/v3_departure.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:redux/redux.dart';

/// Reducer
final AppState Function(AppState, dynamic) appStateReducer =
    combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, ActionStoreLocation>(_storeLocation),
  TypedReducer<AppState, ActionStoreHome>(_storeHome),
  TypedReducer<AppState, ActionAddProblem>(_addProblem),
  TypedReducer<AppState, ActionStoreNearbyStops>(_storeNearbyStopsWithTypes),
  TypedReducer<AppState, ActionStoreDepartures>(_storeDeparturesByRoute),
  TypedReducer<AppState, ActionStoreRoutes>(_storeRoutes),
]);

//
AppState _storeHome(AppState state, ActionStoreHome action) =>
    state.rebuild((b) => b..homeIndex = action.index);

AppState _addProblem(AppState state, ActionAddProblem action) =>
    state.rebuild((b) => b..problems.add(action.problem));

AppState _storeLocation(AppState state, ActionStoreLocation action) =>
    state.rebuild((b) => b
      ..location.latitude = action.location.latitude
      ..location.longitude = action.location.longitude
      ..location.timestamp = action.location.timestamp);

AppState _storeNearbyStopsWithTypes(
        AppState state, ActionStoreNearbyStops action) =>
    state.rebuild((b) => b..nearbyStops = action.nearbyStops.toBuilder());

AppState _storeDeparturesByRoute(AppState state, ActionStoreDepartures action) {
  BuiltMap<int, BuiltList<V3Departure>> departuresByRoute =
      BuiltMap<int, BuiltList<V3Departure>>();

  for (V3Departure departure in action.response.departures) {
    departuresByRoute = departuresByRoute.rebuild((b) =>
        b..putIfAbsent(departure.directionId, () => BuiltList<V3Departure>()));
    departuresByRoute = departuresByRoute.rebuild((b) =>
        b[departure.directionId] =
            b[departure.directionId].rebuild((b) => b..add(departure)));
  }

  return state
      .rebuild((b) => b..departuresByRoute = departuresByRoute.toBuilder());
}

AppState _storeRoutes(AppState state, ActionStoreRoutes action) =>
    state.rebuild((b) => b..routes = action.response.toBuilder());
