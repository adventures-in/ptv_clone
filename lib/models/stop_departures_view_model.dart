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

abstract class StopDeparturesViewModel
    implements Built<StopDeparturesViewModel, StopDeparturesViewModelBuilder> {
  V3DeparturesResponse get departuresResponse;
  int get numDepartures;
  DateTime get nowTime;
  BuiltList<int> get routeIds;
  BuiltList<V3Route> get routes;
  BuiltList<V3Departure> get nextDepartures;
  BuiltList<BuiltList<V3Departure>> get todaysDepartureLists;
  BuiltList<DateTime> get scheduledLocalTimes;
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
