import 'package:flutter/foundation.dart';
import 'package:ptv_clone/models/problem.dart';

class ActionSetHome {
  const ActionSetHome({@required this.index});
  final int index;
}

class ActionAddProblem {
  const ActionAddProblem({@required this.problem});
  final Problem problem;
}

class ActionRequestLocation {
  const ActionRequestLocation();
}

class ActionStoreLocation {
  const ActionStoreLocation(
      {@required this.latitude,
      @required this.longitude,
      @required this.timestamp});
  final double latitude;
  final double longitude;
  final DateTime timestamp;
}
