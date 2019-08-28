import 'package:flutter/foundation.dart';
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
  ActionStoreLocation(
      {@required this.latitude,
      @required this.longitude,
      @required this.timestamp})
      : super({
          'latitude': latitude,
          'longitude': longitude,
          'timestamp': timestamp
        });
  final double latitude;
  final double longitude;
  final DateTime timestamp;
}

// class ActionSetNearbyStops extends Action {
//   ActionSetNearbyStops()
//   final
// }
