library built_app_state;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ptv_clone/models/built_location.dart';
import 'package:ptv_clone/models/problem.dart';
import 'package:ptv_clone/models/serializers.dart';

part 'built_app_state.g.dart';

/// [BuiltAppState] holds the state of the entire app.
///
/// [homeIndex] is an index for the current home page.
/// [problems] is a list of [Problem] objects that the app can observe and
/// deal with in whatever way is appropriate.
abstract class BuiltAppState
    implements Built<BuiltAppState, BuiltAppStateBuilder> {
  int get homeIndex;
  BuiltList<Problem> get problems;
  BuiltLocation get location;

  static BuiltAppState initialState() => BuiltAppState((b) => b
    ..homeIndex = 0
    ..problems = ListBuilder<Problem>()
    ..location.latitude = 0
    ..location.longitude = 0
    ..location.timestamp = DateTime.now());

  BuiltAppState._();

  factory BuiltAppState([updates(BuiltAppStateBuilder b)]) = _$BuiltAppState;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BuiltAppState.serializer, this));
  }

  static BuiltAppState fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltAppState.serializer, json.decode(jsonString));
  }

  static Serializer<BuiltAppState> get serializer => _$builtAppStateSerializer;
}
