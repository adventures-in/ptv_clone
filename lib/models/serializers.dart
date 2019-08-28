import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:ptv_clone/models/built_app_state.dart';
import 'package:ptv_clone/models/built_location.dart';
import 'package:ptv_clone/models/built_stop_location.dart';
import 'package:ptv_clone/models/problem.dart';

part 'serializers.g.dart';

/// Once per app, define a top level "Serializer" to gather together
/// all the generated serializers.
///
/// Collection of generated serializers for the built_value chat example.
@SerializersFor(const [
  BuiltAppState,
  BuiltLocation,
  BuiltStopLocation,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
