import 'package:ptv_clone/utilities/credentials.dart';
import 'package:swagger/api.dart';

class ApiService {
  ApiService();

  final DeparturesApi apiInstance = DeparturesApi();

  // Number identifying transport mode; values returned via RouteTypes API
  final int routeType = 56;
  // Identifier of stop; values returned by Stops API
  final int stopId = 56;
  // Filter by platform number at stop
  final List<int> platformNumbers = [];
  // Filter by identifier of direction of travel; values returned by Directions API - /v3/directions/route/{route_id}
  final int directionId = 56;
  // Indicates if filtering runs (and their departures) to those that arrive at destination before date_utc (default = false). Requires max_results &gt; 0.
  final bool lookBackwards = true;
  // Indicates that stop_id parameter will accept \"GTFS stop_id\" data
  final bool gtfs = true;
  // Filter by the date and time of the request (ISO 8601 UTC format) (default = current date and time)
  final DateTime dateUtc = DateTime.parse('2013-10-20T19:20:30+01:00');
  // Maximum number of results returned
  final int maxResults = 56;
  // Indicates if cancelled services (if they exist) are returned (default = false) - metropolitan train only
  final bool includeCancelled = true;
  // List objects to be returned in full (i.e. expanded) - options include: all, stop, route, run, direction, disruption
  final List<String> expand = [];
  // Your developer id
  final String devid = credentials['uid'];
  // Authentication signature for request
  final signature = 'signature_example';

  // dateUtc, maxResults, includeCancelled, expand, uid, signature
  call() async {
    try {
      V3DeparturesResponse result = await apiInstance.departuresGetForStop(
          routeType, stopId,
          platformNumbers: platformNumbers,
          directionId: directionId,
          lookBackwards: lookBackwards,
          gtfs: gtfs,
          dateUtc: dateUtc,
          maxResults: maxResults,
          includeCancelled: includeCancelled,
          expand: expand,
          devid: devid,
          signature: signature);
      print(result);
    } catch (e) {
      print("Exception when calling DeparturesApi->departuresGetForStop: $e\n");
    }
  }
}
