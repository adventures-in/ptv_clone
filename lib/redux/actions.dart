import 'package:flutter/foundation.dart';
import 'package:ptv_api_client/model/v3_stops_by_distance_response.dart';
import 'package:ptv_clone/models/location.dart';
import 'package:ptv_clone/models/problem.dart';

class Action {
  const Action(this.propsMap);

  Action.fromJson(Map<String, dynamic> json) : propsMap = json;

  final Map<String, dynamic> propsMap;

  Map<String, dynamic> toJson() => propsMap;
}

class ActionSetHome extends Action {
  ActionSetHome({@required this.index}) : super({'index': index});
  final int index;
}

class ActionAddProblem extends Action {
  ActionAddProblem({@required this.problem}) : super({'problem': problem});
  final Problem problem;
}

class ActionObserveLocation extends Action {
  const ActionObserveLocation() : super(const {});
}

class ActionStoreLocation extends Action {
  ActionStoreLocation({@required this.location})
      : super({'latitude': location});
  final Location location;
}

class ActionStoreNearbyStops extends Action {
  ActionStoreNearbyStops({@required this.response})
      : super({'response': response});
  final V3StopsByDistanceResponse response;
}
