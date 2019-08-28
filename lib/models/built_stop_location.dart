library built_stop_location;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ptv_clone/models/serializers.dart';

part 'built_stop_location.g.dart';

/// Converted V3StopGeosearch
abstract class BuiltStopLocation
    implements Built<BuiltStopLocation, BuiltStopLocationBuilder> {
  BuiltList<int> get disruptionIds;
  double get stopDistance;
  String get stopSuburb;
  String get stopName;
  int get stopId;
  int get routeType;
  double get stopLatitude;
  double get stopLongitude;
  int get stopSequence;

  BuiltStopLocation._();

  factory BuiltStopLocation([updates(BuiltStopLocationBuilder b)]) =
      _$BuiltStopLocation;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BuiltStopLocation.serializer, this));
  }

  static BuiltStopLocation fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltStopLocation.serializer, json.decode(jsonString));
  }

  static Serializer<BuiltStopLocation> get serializer =>
      _$builtStopLocationSerializer;
}
