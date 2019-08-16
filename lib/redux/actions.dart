import 'package:flutter/foundation.dart';
import 'package:ptv_clone/models/location.dart';
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
  const ActionStoreLocation({@required this.location});
  final Location location;
}
