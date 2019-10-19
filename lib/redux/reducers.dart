import 'package:built_collection/built_collection.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_api_client/model/v3_route_with_status.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/models/stop_departure_item.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:redux/redux.dart';

/// Reducer
final AppState Function(AppState, dynamic) appStateReducer =
    combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, ActionStoreHome>(_storeHome),
  TypedReducer<AppState, ActionAddProblem>(_addProblem),
  TypedReducer<AppState, ActionStoreStopDepartures>(_storeStopDepartures),
  TypedReducer<AppState, ActionStoreLocation>(_storeLocation),
  TypedReducer<AppState, ActionStoreNearbyStops>(_storeNearbyStops),
  TypedReducer<AppState, ActionStoreRoutes>(_storeStopRoutes),
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

AppState _storeNearbyStops(AppState state, ActionStoreNearbyStops action) =>
    state.rebuild((b) => b..nearbyStops = action.nearbyStops.toBuilder());

AppState _storeStopDepartures(
    AppState state, ActionStoreStopDepartures action) {
  BuiltList<StopDepartureItem> items = ListBuilder<StopDepartureItem>().build();
  for (V3Departure departure in action.response.departures) {
    final route = action.response.routes[departure.routeId.toString()];
    final run = action.response.runs[departure.runId.toString()];
    final scheduledTime = departure.scheduledDepartureUtc.toLocal();
    final scheduledHour = scheduledTime.hour;
    final scheduledMins = scheduledTime.minute;
    items.rebuild(
      (b) => b
        ..add(
          StopDepartureItem(
            (b) => b
              ..routeName = route.routeName
              ..routeNumber = route.routeNumber
              ..destinationName = run.destinationName
              ..scheduledTime =
                  '${scheduledHour.toString().padLeft(2)}:${scheduledMins.toString().padLeft(2)}',
          ),
        ),
    );
  }

  return state.rebuild(
    (b) => b
      ..stopDeparturesResponse = action.response.toBuilder()
      ..stopDeparturesViewModel = items.toBuilder(),
  );
}

AppState _storeStopRoutes(AppState state, ActionStoreRoutes action) {
  final routesById = Map<int, V3RouteWithStatus>();
  for (V3RouteWithStatus route in action.response.routes) {
    routesById[route.routeId] = route;
  }
  final builtRoutesById = BuiltMap<int, V3RouteWithStatus>(routesById);
  return state.rebuild((b) => b..routesById = builtRoutesById.toBuilder());
}

// V3Departure nextDeparture;
//                       final routeId = departuresByRoute.keys.elementAt(index);
//                       for (V3Departure departure
//                           in departuresByRoute[routeId]) {
//                         if (departure.scheduledDepartureUtc.isAfter(nowTime)) {
//                           nextDeparture = departure;
//                           break;
//                         }
//                       }

//                       StoreProvider.of<AppState>(context).dispatch(
//                         ActionGetDeparturesForRoute(
//                           routeType: stop.routeType,
//                           stopId: stop.stopId,
//                           routeId: routeId.toString(),
//                         ),
//                       );

//

//                       Duration duration;
//                       if (nextDeparture.estimatedDepartureUtc != null) {
//                         duration = nowTime
//                             .difference(nextDeparture.estimatedDepartureUtc);
//                       } else {
//                         duration = nextDeparture.scheduledDepartureUtc
//                             .difference(nowTime);
//                       }

//
//
//
// '${duration.inMinutes}'
