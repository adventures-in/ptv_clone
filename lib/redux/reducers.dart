import 'package:built_collection/built_collection.dart';
import 'package:ptv_api_client/model/v3_departure.dart';
import 'package:ptv_api_client/model/v3_route_with_status.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:redux/redux.dart';

/// Reducer
final AppState Function(AppState, dynamic) appStateReducer =
    combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, ActionStoreHome>(_storeHome),
  TypedReducer<AppState, ActionAddProblem>(_addProblem),
  TypedReducer<AppState, ActionStoreDepartures>(_storeDeparturesByRoute),
  TypedReducer<AppState, ActionStoreLocation>(_storeLocation),
  TypedReducer<AppState, ActionStoreNearbyStops>(_storeNearbyStopsWithTypes),
  TypedReducer<AppState, ActionStoreRoutes>(_storeRoutes),
]);

//
AppState _storeHome(AppState state, ActionStoreHome action) =>
    state.rebuild((b) => b..homeIndex = action.index);

AppState _addProblem(AppState state, ActionAddProblem action) =>
    state.rebuild((b) => b..problems.add(action.problem));

AppState _storeDeparturesByRoute(AppState state, ActionStoreDepartures action) {
  // TODO(nickm):
  //  - create a class to hold 2 members: routeId and directionId (DepartureIdentifier)
  //  - create a Map<DepartureIdentifier, List<V3Departure>>
  //  - iterate over V3DepartureResponse and populate map
  //  - calculate nextDeparture for each DepartureIdentifier

  // BuiltMap<int, BuiltList<V3Departure>> departuresByRoute =
  //     BuiltMap<int, BuiltList<V3Departure>>();

  // for (V3Departure departure in action.response.departures) {
  //   departuresByRoute = departuresByRoute.rebuild((b) =>
  //       b..putIfAbsent(departure.directionId, () => BuiltList<V3Departure>()));
  //   departuresByRoute = departuresByRoute.rebuild((b) =>
  //       b[departure.directionId] =
  //           b[departure.directionId].rebuild((b) => b..add(departure)));
  // }

  // return state
  //     .rebuild((b) => b..departuresByRoute = departuresByRoute.toBuilder());

  // return state.rebuild((b) => b
  //   ..stopDeparturesViewModel.departuresResponse = action.response.toBuilder());

  final departuresByRoute = Map<int, List<V3Departure>>();
  final nextDeparturesByRoute = Map<int, V3Departure>();
  for (V3Departure departure in action.response.departures) {
    // store all departures against the routeId, in order
    departuresByRoute[departure.routeId] ??= List<V3Departure>();
    departuresByRoute[departure.routeId].add(departure);
  }
  // for (List<V3Departure> departures in departuresByRoute.values) {
  //   for(V3Departure departure in departures) {

  //   }
  //   // store the next departure for each
  //   if(nextDeparturesByRoute[departure.routeId] == null) {
  //     nextDeparturesByRoute[departure.routeId] = departure;
  //   }
  //   else {
  //     nextDeparturesByRoute[departure.routeId].
  //   }
  // }

  // final nextDepartureTimeStrings = List<String>();
  // final DateTime scheduledLocalTime = nextDeparture.scheduledDepartureUtc.toLocal();
  // final amPm = (scheduledLocalTime.hour < 12) ? 'am' : 'pm';
  // String timeString =
  //       '${scheduledLocalTime.hour}:${scheduledLocalTime.minute} $amPm to ';
  //   nextDepartureTimeStrings.add

  final listOfDepartureLists = List<BuiltList<V3Departure>>();
  for (List<V3Departure> list in departuresByRoute.values) {
    listOfDepartureLists.add(BuiltList<V3Departure>(list));
  }

  return state.rebuild((b) => b
    ..stopDeparturesViewModel.departuresResponse = action.response.toBuilder()
    ..stopDeparturesViewModel.numDepartures = departuresByRoute.keys.length
    ..stopDeparturesViewModel.routeIds =
        ListBuilder<int>(departuresByRoute.keys)
    ..stopDeparturesViewModel.todaysDepartureLists =
        BuiltList<BuiltList<V3Departure>>(listOfDepartureLists).toBuilder());
}

AppState _storeLocation(AppState state, ActionStoreLocation action) =>
    state.rebuild((b) => b
      ..location.latitude = action.location.latitude
      ..location.longitude = action.location.longitude
      ..location.timestamp = action.location.timestamp);

AppState _storeNearbyStopsWithTypes(
        AppState state, ActionStoreNearbyStops action) =>
    state.rebuild((b) => b..nearbyStops = action.nearbyStops.toBuilder());

AppState _storeRoutes(AppState state, ActionStoreRoutes action) {
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
