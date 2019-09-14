import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:ptv_api_client/model/v3_departure.dart';
import 'package:ptv_api_client/model/v3_departures_response.dart';
import 'package:ptv_api_client/model/v3_direction.dart';
import 'package:ptv_api_client/model/v3_disruption.dart';
import 'package:ptv_api_client/model/v3_disruption_direction.dart';
import 'package:ptv_api_client/model/v3_disruption_route.dart';
import 'package:ptv_api_client/model/v3_disruption_stop.dart';
import 'package:ptv_api_client/model/v3_result_stop.dart';
import 'package:ptv_api_client/model/v3_route.dart';
import 'package:ptv_api_client/model/v3_route_service_status.dart';
import 'package:ptv_api_client/model/v3_route_with_status.dart';
import 'package:ptv_api_client/model/v3_run.dart';
import 'package:ptv_api_client/model/v3_status.dart';
import 'package:ptv_api_client/model/v3_stop_geosearch.dart';
import 'package:ptv_api_client/model/v3_stops_by_distance_response.dart';
import 'package:ptv_api_client/model/v3_vehicle_descriptor.dart';
import 'package:ptv_api_client/model/v3_vehicle_position.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/models/location.dart';
import 'package:ptv_clone/models/problem.dart';
import 'package:ptv_clone/models/stop_departures_view_model.dart';

part 'serializers.g.dart';

/// Once per app, define a top level "Serializer" to gather together
/// all the generated serializers.
///
/// Collection of generated serializers for the built_value chat example.
@SerializersFor([AppState, Location, V3Departure])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..add(Iso8601DateTimeSerializer())
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(V3Departure)]),
        () => ListBuilder<V3Departure>(),
      ))
    .build();
