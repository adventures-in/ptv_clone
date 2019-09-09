import 'package:flutter/foundation.dart';
import 'package:ptv_api_client/model/v3_departures_response.dart';
import 'package:ptv_api_client/model/v3_routes_response.dart';
import 'package:ptv_api_client/model/v3_stop_response.dart';
import 'package:ptv_api_client/model/v3_stops_by_distance_response.dart';
import 'package:ptv_clone/models/location.dart';
import 'package:ptv_clone/models/problem.dart';

class Action {
  const Action(this.propsMap);
  Action.fromJson(Map<String, dynamic> json) : propsMap = json;
  final Map<String, dynamic> propsMap;
  Map<String, dynamic> toJson() => propsMap;
}

class ActionStoreNamedRoute extends Action {
  ActionStoreNamedRoute({@required this.routeName})
      : super(<String, Object>{'routeName': routeName});
  final String routeName;
}

class ActionStoreHome extends Action {
  ActionStoreHome({@required this.index})
      : super(<String, Object>{'index': index});
  final int index;
}

class ActionAddProblem extends Action {
  ActionAddProblem({@required this.problem})
      : super(<String, Object>{'problem': problem});
  final Problem problem;
}

class ActionObserveLocation extends Action {
  const ActionObserveLocation() : super(const <String, Object>{});
}

class ActionStoreLocation extends Action {
  ActionStoreLocation({@required this.location})
      : super(<String, Object>{'latitude': location});
  final Location location;
}

class ActionStoreNearbyStops extends Action {
  ActionStoreNearbyStops({@required this.nearbyStops})
      : super(<String, Object>{'nearbyStops': nearbyStops});
  final V3StopsByDistanceResponse nearbyStops;
}

class ActionGetRoutes extends Action {
  const ActionGetRoutes() : super(const <String, Object>{});
}

class ActionStoreRoutes extends Action {
  ActionStoreRoutes({@required this.response})
      : super(<String, Object>{'response': response});
  final V3RoutesResponse response;
}

class ActionGetStopDetails extends Action {
  ActionGetStopDetails({@required this.stopId, @required this.routeType})
      : super(<String, Object>{'stopId': stopId, 'routeType': routeType});
  final int stopId;
  final int routeType;
}

class ActionStoreStopDetails extends Action {
  ActionStoreStopDetails({@required this.response})
      : super(<String, Object>{'response': response});
  final V3StopResponse response;
}

class ActionGetDepartures extends Action {
  ActionGetDepartures({@required this.stopId, @required this.routeType})
      : super(<String, Object>{'stopId': stopId, 'routeType': routeType});
  final int stopId;
  final int routeType;
}

class ActionStoreDepartures extends Action {
  ActionStoreDepartures({@required this.response})
      : super(<String, Object>{'response': response});
  final V3DeparturesResponse response;
}
