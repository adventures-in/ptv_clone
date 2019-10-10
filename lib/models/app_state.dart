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
  V3DeparturesResponse get stopDepartures;

  static AppState initialState() => AppState(
        (b) => b
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
          ..stopDepartures.departures = ListBuilder<V3Departure>()
          ..stopDepartures.directions = MapBuilder<String, V3Direction>()
          ..stopDepartures.disruptions = MapBuilder<String, V3Disruption>()
          ..stopDepartures.routes = MapBuilder<String, V3Route>()
          ..stopDepartures.runs = MapBuilder<String, V3Run>()
          ..stopDepartures.status.health = 0
          ..stopDepartures.status.version = ''
          ..stopDepartures.stops = MapBuilder<String, V3ResultStop>(),
      );

  AppState._();

  factory AppState([void updates(AppStateBuilder b)]) = _$AppState;

  Object toJson() => serializers.serializeWith(AppState.serializer, this);

  static AppState fromJson(String jsonString) =>
      serializers.deserializeWith(AppState.serializer, json.decode(jsonString));

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
