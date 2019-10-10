// Import the test package and Counter class
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:ptv_api_client/model/v3_departure.dart';
import 'package:ptv_api_client/model/v3_departures_response.dart';
import 'package:ptv_clone/models/app_state.dart';
import 'package:test/test.dart';

void main() {
  test('Counter value should be incremented', () async {
    File file = File('test/unit_tests/data.json');
    String json = await file.readAsString();

    final response = V3DeparturesResponse.fromJson(json);

    BuiltMap<int, BuiltList<V3Departure>> departuresByRoute =
        BuiltMap<int, BuiltList<V3Departure>>();

    AppState state = AppState.initialState();

    for (V3Departure departure in response.departures) {
      departuresByRoute = departuresByRoute.rebuild(
        (b) => b
          ..putIfAbsent(
            departure.directionId,
            () => BuiltList<V3Departure>(),
          ),
      );
      departuresByRoute = departuresByRoute.rebuild(
        (b) => b[departure.directionId] = b[departure.directionId].rebuild(
          (b) => b..add(departure),
        ),
      );
    }

    // departuresByRoute was removed from AppState, need to update test

    // state = state.rebuild(
    //   (b) => b..departuresByRoute = departuresByRoute.toBuilder(),
    // );

    // print(state);

    // expect(response.departures.length, greaterThan(0));
  });
}
