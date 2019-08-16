library built_location;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ptv_clone/models/serializers.dart';

part 'built_location.g.dart';

abstract class BuiltLocation
    implements Built<BuiltLocation, BuiltLocationBuilder> {
  double get latitude;
  double get longitude;
  DateTime get timestamp;

  BuiltLocation._();

  factory BuiltLocation([updates(BuiltLocationBuilder b)]) = _$BuiltLocation;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BuiltLocation.serializer, this));
  }

  static BuiltLocation fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltLocation.serializer, json.decode(jsonString));
  }

  static Serializer<BuiltLocation> get serializer => _$builtLocationSerializer;
}
