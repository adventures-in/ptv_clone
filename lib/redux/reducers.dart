import 'package:built_collection/built_collection.dart';
import 'package:ptv_api_client/model/v3_departure.dart';
import 'package:ptv_api_client/model/v3_route_with_status.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/models/stop_departures_view_model.dart';
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
  final departuresByCategory = Map<DepartureCategory, List<V3Departure>>();
  for (V3Departure departure in action.response.departures) {
    final category =
        DepartureCategory(departure.routeId, departure.directionId);
    // store all departures against the routeId, in order
    departuresByCategory[category] ??= List<V3Departure>();
    departuresByCategory[category].add(departure);
  }

  final routeIds = List<int>();
  final nextDepartures = Map<DepartureCategory, V3Departure>();
  final nowUtc = DateTime.now().toUtc();
  final nextDepartureTimeStrings = Map<DepartureCategory, String>();
  for (DepartureCategory category in departuresByCategory.keys) {
    routeIds.add(category.routeId);
    nextDepartures[category] = departuresByCategory[category].firstWhere(
        (departure) => departure.scheduledDepartureUtc.isAfter(nowUtc),
        orElse: () => departuresByCategory[category].last);

    final DateTime scheduledLocalTime =
        nextDepartures[category].scheduledDepartureUtc.toLocal();
    final amPm = (scheduledLocalTime.hour < 12) ? 'AM' : 'PM';
    String timeString =
        '${scheduledLocalTime.hour}:${scheduledLocalTime.minute} $amPm';
    nextDepartureTimeStrings[category] = timeString;
  }

  final listOfDepartureLists = List<BuiltList<V3Departure>>();
  for (List<V3Departure> list in departuresByCategory.values) {
    listOfDepartureLists.add(BuiltList<V3Departure>(list));
  }

  return state.rebuild(
    (b) => b
      ..stopDeparturesViewModel.departuresResponse = action.response.toBuilder()
      ..stopDeparturesViewModel.numDepartures = departuresByCategory.keys.length
      ..stopDeparturesViewModel.routeIds = ListBuilder<int>(routeIds)
      ..stopDeparturesViewModel.todaysDepartures =
          ListBuilder<BuiltList<V3Departure>>(listOfDepartureLists)
      ..stopDeparturesViewModel.nextDepartures =
          ListBuilder<V3Departure>(nextDepartures.values)
      ..stopDeparturesViewModel.timeStrings =
          ListBuilder<String>(nextDepartureTimeStrings.values),
  );
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
