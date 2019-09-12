import 'package:meta/meta.dart';
import 'package:ptv_api_client/api.dart';

import 'package:ptv_clone/utilities/credentials.dart';

/// Departures
///  - departuresGetForStop
///  - departuresGetForStopAndRoute
/// Directons
///  - directionsForDirection
///  - directionsForDirectionAndType
///  - directionsForRoute
/// Disruptions
///  - disruptionsGetAllDisruptions
///  - disruptionsGetDisruptionById
///  - disruptionsGetDisruptionModes
///  - disruptionsGetDisruptionsByRoute
///  - disruptionsGetDisruptionsByRouteAndStop
///  - disruptionsGetDisruptionsByStop
/// Outlets
///  - outletsGetAllOutlets
///  - outletsGetOutletsByGeolocation
/// Patterns
///  - patternsGetPatternByRun
/// Routes
///  - routesOneOrMoreRoutes
///  - routesRouteFromId
/// RouteTypes
///  - routeTypesGetRouteTypes
/// Runs
///  - runsForRoute
/// Search
///  - searchSearch
/// Stops
///  - stopsStopDetails
///  - stopsStopsByGeolocation
///  - stopsStopsForRoute

class ApiService {
  ApiService(
      this.departuresApi,
      this.directionsApi,
      this.disruptionsApi,
      this.outletsApi,
      this.patternsApi,
      this.routesApi,
      this.routeTypesApi,
      this.runsApi,
      this.searchApi,
      this.stopsApi) {
    defaultApiClient.setCredentials(credentials['key'], credentials['uid']);
  }

  final DeparturesApi departuresApi;
  final DirectionsApi directionsApi;
  final DisruptionsApi disruptionsApi;
  final OutletsApi outletsApi;
  final PatternsApi patternsApi;
  final RoutesApi routesApi;
  final RouteTypesApi routeTypesApi;
  final RunsApi runsApi;
  final SearchApi searchApi;
  final StopsApi stopsApi;

  /////////////////////////////////////////////////////////////////////
  /// Departures
  /////////////////////////////////////////////////////////////////////

  Future<V3DeparturesResponse> getDeparturesForStopAndRoute(
          {@required int routeType,
          @required int stopId,
          @required String routeId,
          int directionId,
          bool lookBackwards,
          bool gtfs,
          DateTime dateUtc,
          int maxResults,
          bool includeCancelled,
          List<String> expand}) =>
      departuresApi.departuresGetForStopAndRoute(routeType, stopId, routeId,
          directionId: directionId,
          lookBackwards: lookBackwards,
          gtfs: gtfs,
          dateUtc: dateUtc,
          maxResults: maxResults,
          includeCancelled: includeCancelled,
          expand: expand);

  Future<V3DeparturesResponse> getDeparturesForStop(
          {@required int routeType,
          @required int stopId,
          List<int> platformNumbers,
          int directionId,
          bool lookBackwards,
          bool gtfs,
          DateTime dateUtc,
          int maxResults,
          bool includeCancelled,
          List<String> expand}) =>
      departuresApi.departuresGetForStop(routeType, stopId,
          platformNumbers: platformNumbers,
          directionId: directionId,
          lookBackwards: lookBackwards,
          gtfs: gtfs,
          dateUtc: dateUtc,
          maxResults: maxResults,
          includeCancelled: includeCancelled,
          expand: expand);

  /////////////////////////////////////////////////////////////////////
  /// Directons
  /////////////////////////////////////////////////////////////////////

  Future<V3DirectionsResponse> getDirectionsForDirection(
          {@required int directionId}) =>
      directionsApi.directionsForDirection(directionId);

  Future<V3DirectionsResponse> getDirectionsForDirectionAndType(
          {@required int directionId, @required int routeType}) =>
      directionsApi.directionsForDirectionAndType(directionId, routeType);

  Future<V3DirectionsResponse> getDirectionsForRoute({@required int routeId}) =>
      directionsApi.directionsForRoute(routeId);

  /////////////////////////////////////////////////////////////////////
  /// Disruptions
  /////////////////////////////////////////////////////////////////////

  Future<V3DisruptionsResponse> getAllDisruptions(
          {List<int> routeTypes,
          List<int> disruptionModes,
          String disruptionStatus}) =>
      disruptionsApi.disruptionsGetAllDisruptions(
          routeTypes: routeTypes,
          disruptionModes: disruptionModes,
          disruptionStatus: disruptionStatus);

  Future<V3DisruptionResponse> getDisruptionById(
          {@required int disruptionId}) =>
      disruptionsApi.disruptionsGetDisruptionById(disruptionId);

  Future<V3DisruptionModesResponse> getDisruptionModes() =>
      disruptionsApi.disruptionsGetDisruptionModes();

  Future<V3DisruptionsResponse> getDisruptionsByRoute(
          {@required int routeId, String disruptionStatus}) =>
      disruptionsApi.disruptionsGetDisruptionsByRoute(routeId,
          disruptionStatus: disruptionStatus);

  Future<V3DisruptionsResponse> getDisruptionsByRouteAndStop(
          {@required int routeId,
          @required int stopId,
          String disruptionStatus}) =>
      disruptionsApi.disruptionsGetDisruptionsByRouteAndStop(routeId, stopId,
          disruptionStatus: disruptionStatus);

  Future<V3DisruptionsResponse> getDisruptionsByStop(
          {@required int stopId, String disruptionStatus}) =>
      disruptionsApi.disruptionsGetDisruptionsByStop(stopId,
          disruptionStatus: disruptionStatus);

  /////////////////////////////////////////////////////////////////////
  /// Outlets
  /////////////////////////////////////////////////////////////////////

  Future<V3OutletResponse> getAllOutlets({int maxResults}) =>
      outletsApi.outletsGetAllOutlets(maxResults: maxResults);

  Future<V3OutletGeolocationResponse> getOutletsByGeolocation(
          {@required double latitude,
          @required double longitude,
          double maxDistance,
          int maxResults}) =>
      outletsApi.outletsGetOutletsByGeolocation(latitude, longitude,
          maxDistance: maxDistance, maxResults: maxResults);

  /////////////////////////////////////////////////////////////////////
  /// Patterns
  /////////////////////////////////////////////////////////////////////

  Future<V3StoppingPattern> getPatternByRun(
          {@required int runId,
          @required int routeType,
          @required List<String> expand,
          int stopId,
          DateTime dateUtc}) =>
      patternsApi.patternsGetPatternByRun(runId, routeType, expand,
          stopId: stopId, dateUtc: dateUtc);

  /////////////////////////////////////////////////////////////////////
  /// Routes
  /////////////////////////////////////////////////////////////////////

  Future<V3RoutesResponse> getRoutes(
          {List<int> routeTypes, String routeName}) =>
      routesApi.routesOneOrMoreRoutes(
          routeTypes: routeTypes, routeName: routeName);

  Future<V3RoutesResponse> getRoutesFromId({@required int routeId}) =>
      routesApi.routesRouteFromId(routeId);

  /////////////////////////////////////////////////////////////////////
  /// RouteTypes
  /////////////////////////////////////////////////////////////////////

  Future<V3RouteTypesResponse> getRouteTypes() =>
      routeTypesApi.routeTypesGetRouteTypes();

  /////////////////////////////////////////////////////////////////////
  /// Runs
  /////////////////////////////////////////////////////////////////////

  Future<V3RunsResponse> getRunsForRoute({@required int routeId}) =>
      runsApi.runsForRoute(routeId);

  /////////////////////////////////////////////////////////////////////
  /// Search
  /////////////////////////////////////////////////////////////////////

  Future<V3SearchResult> getS(
          {@required String searchTerm,
          List<int> routeTypes,
          double latitude,
          double longitude,
          double maxDistance,
          bool includeAddresses,
          bool includeOutlets,
          bool matchStopBySuburb,
          bool matchRouteBySuburb,
          bool matchStopByGtfsStopId}) =>
      searchApi.searchSearch(searchTerm,
          routeTypes: routeTypes,
          latitude: latitude,
          longitude: longitude,
          maxDistance: maxDistance,
          includeAddresses: includeAddresses,
          includeOutlets: includeOutlets,
          matchStopBySuburb: matchStopBySuburb,
          matchRouteBySuburb: matchRouteBySuburb,
          matchStopByGtfsStopId: matchStopByGtfsStopId);

  /////////////////////////////////////////////////////////////////////
  /// Stops
  /////////////////////////////////////////////////////////////////////

  Future<V3StopResponse> getStopDetails(
          {@required int stopId,
          @required int routeType,
          bool stopLocation,
          bool stopAmenities,
          bool stopAccessibility,
          bool stopContact,
          bool stopTicket,
          bool gtfs,
          bool stopStaffing,
          bool stopDisruptions}) =>
      stopsApi.stopsStopDetails(stopId, routeType,
          stopLocation: stopLocation,
          stopAmenities: stopAmenities,
          stopAccessibility: stopAccessibility,
          stopContact: stopContact,
          stopTicket: stopTicket,
          gtfs: gtfs,
          stopStaffing: stopStaffing,
          stopDisruptions: stopDisruptions);

  Future<V3StopsByDistanceResponse> getStopsByGeolocation(
          {@required double latitude,
          @required double longitude,
          List<int> routeTypes,
          int maxResults,
          double maxDistance,
          bool stopDisruptions}) =>
      stopsApi.stopsStopsByGeolocation(latitude, longitude,
          routeTypes: routeTypes,
          maxResults: maxResults,
          maxDistance: maxDistance,
          stopDisruptions: stopDisruptions);

  Future<V3StopsOnRouteResponse> getStop(
          {@required int routeId,
          @required int routeType,
          int directionId,
          bool stopDisruptions}) =>
      stopsApi.stopsStopsForRoute(routeId, routeType,
          directionId: directionId, stopDisruptions: stopDisruptions);
}
