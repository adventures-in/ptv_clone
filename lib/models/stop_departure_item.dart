library stop_departure_item;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ptv_api_client/serializers.dart';

part 'stop_departure_item.g.dart';

abstract class StopDepartureItem
    implements Built<StopDepartureItem, StopDepartureItemBuilder> {
  String get scheduledTime;
  String get estimatedTime;
  String get estimatedDuration;
  String get routeNumber;
  String get routeName;
  String get destinationName;

  StopDepartureItem._();

  factory StopDepartureItem([void updates(StopDepartureItemBuilder b)]) =
      _$StopDepartureItem;

  Object toJson() => json
      .encode(serializers.serializeWith(StopDepartureItem.serializer, this));

  static StopDepartureItem fromJson(String jsonString) => serializers
      .deserializeWith(StopDepartureItem.serializer, json.decode(jsonString));

  static Serializer<StopDepartureItem> get serializer =>
      _$stopDepartureItemSerializer;
}
