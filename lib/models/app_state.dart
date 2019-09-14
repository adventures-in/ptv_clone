library app_state;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ptv_api_client/api.dart';
import 'package:ptv_api_client/model/v3_stops_by_distance_response.dart';
import 'package:ptv_clone/models/location.dart';
import 'package:ptv_clone/models/problem.dart';
import 'package:ptv_clone/models/serializers.dart';
import 'package:ptv_clone/models/stop_departures_view_model.dart';

part 'app_state.g.dart';

/// [AppState] holds the state of the entire app.
///
/// [homeIndex] is an index for the current home page.
/// [problems] is a list of [Problem] objects that the app can observe and
/// deal with in whatever way is appropriate.
abstract class AppState implements Built<AppState, AppStateBuilder> {
  int get homeIndex;
  BuiltList<Problem> get problems;
  Location get location;
  BuiltMap<int, V3RouteWithStatus> get routesById;
  V3StopsByDistanceResponse get nearbyStops;
  StopDeparturesViewModel get stopDeparturesViewModel;
  BuiltMap<int, BuiltList<V3Departure>> get departuresByRoute;
  BuiltMap<String, V3DeparturesResponse> get departureDetailsByRoute;

  static AppState initialState() => AppState((b) => b
    ..homeIndex = 0
    ..problems = ListBuilder<Problem>()
    ..location.latitude = 0
    ..location.longitude = 0
    ..location.timestamp = DateTime.now().toUtc()
    ..routesById = MapBuilder<int, V3RouteWithStatus>()
    ..nearbyStops.disruptions = MapBuilder<String, V3Disruption>()
    ..nearbyStops.status.health = 0
    ..nearbyStops.status.version = ''
    ..nearbyStops.stops = ListBuilder<V3StopGeosearch>()
    ..stopDeparturesViewModel.departuresResponse.status.health = 0
    ..stopDeparturesViewModel.departuresResponse.status.version = ''
    ..stopDeparturesViewModel.departuresResponse.departures =
        ListBuilder<V3Departure>()
    ..stopDeparturesViewModel.departuresResponse.directions =
        MapBuilder<String, V3Direction>()
    ..stopDeparturesViewModel.departuresResponse.disruptions =
        MapBuilder<String, V3Disruption>()
    ..stopDeparturesViewModel.departuresResponse.routes =
        MapBuilder<String, V3Route>()
    ..stopDeparturesViewModel.departuresResponse.runs =
        MapBuilder<String, V3Run>()
    ..stopDeparturesViewModel.departuresResponse.stops =
        MapBuilder<String, V3ResultStop>()
    ..stopDeparturesViewModel.nextDepartures = ListBuilder<V3Departure>()
    ..stopDeparturesViewModel.nowTime = DateTime.now().toUtc()
    ..stopDeparturesViewModel.routeIds = ListBuilder<int>()
    ..stopDeparturesViewModel.routes = ListBuilder<V3Route>()
    ..stopDeparturesViewModel.scheduledLocalTimes = ListBuilder<DateTime>()
    ..stopDeparturesViewModel.timeStrings = ListBuilder<String>()
    ..stopDeparturesViewModel.todaysDepartureLists =
        ListBuilder<BuiltList<V3Departure>>()
    ..stopDeparturesViewModel.numDepartures = 0
    ..departuresByRoute = MapBuilder<int, BuiltList<V3Departure>>()
    ..departureDetailsByRoute = MapBuilder<String, V3DeparturesResponse>());

  AppState._();

  factory AppState([void updates(AppStateBuilder b)]) = _$AppState;

  Object toJson() => serializers.serializeWith(AppState.serializer, this);

  static AppState fromJson(String jsonString) =>
      serializers.deserializeWith(AppState.serializer, json.decode(jsonString));

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
