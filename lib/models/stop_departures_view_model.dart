library stop_departures_view_model;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ptv_api_client/model/v3_departure.dart';
import 'package:ptv_api_client/model/v3_departures_response.dart';
import 'package:ptv_api_client/model/v3_route.dart';
import 'package:ptv_clone/models/serializers.dart';

part 'stop_departures_view_model.g.dart';

/// ViewModel for [StopDeparturesPage]
///
/// [departuresResponse] stores the whole response from the [getDeparturesForStop] api call
/// [numDepartures] is how many unique departures occur from this stop
/// [routeIds] identify the different routes that include this stop
/// [routes] are the full objects for the routes, copied from [AppState.routesById]
///  which are requested on app load with [getRoutes]
/// [nextDepartures] is a list containing the next departure for each route
/// [todaysDepartures] is a list of departures for routes (a list of lists).
///  The departures are re-organised from [departuresResponse]
/// [timeStrings] is a list of strings, with the time of departure for each route
/// [durationStrings] is a list of strings, with the time of departure for each route, represented as a duration
abstract class StopDeparturesViewModel
    implements Built<StopDeparturesViewModel, StopDeparturesViewModelBuilder> {
  V3DeparturesResponse get departuresResponse;
  int get numDepartures;
  BuiltList<int> get routeIds;
  BuiltList<V3Route> get routes;
  BuiltList<V3Departure> get nextDepartures;
  BuiltList<BuiltList<V3Departure>> get todaysDepartures;
  BuiltList<String> get timeStrings;
  BuiltList<String> get durationStrings;

  StopDeparturesViewModel._();

  factory StopDeparturesViewModel(
          [void updates(StopDeparturesViewModelBuilder b)]) =
      _$StopDeparturesViewModel;

  String toJson() {
    return json.encode(
        serializers.serializeWith(StopDeparturesViewModel.serializer, this));
  }

  static StopDeparturesViewModel fromJson(String jsonString) {
    return serializers.deserializeWith(
        StopDeparturesViewModel.serializer, json.decode(jsonString));
  }

  static Serializer<StopDeparturesViewModel> get serializer =>
      _$stopDeparturesViewModelSerializer;
}

/// Departures for a stop are not organised into distinct groups in the data
/// returned by the API so we need to sort them. A [Departure] is on a [Route]
/// but using just the routeId misses the same route with a different [Direction].
class DepartureCategory {
  const DepartureCategory(this.routeId, this.directionId);
  final int routeId;
  final int directionId;

  @override
  bool operator ==(Object other) =>
      other is DepartureCategory &&
      other.routeId == this.routeId &&
      other.directionId == this.directionId;

  int get hashCode => routeId.hashCode ^ directionId.hashCode;
}
