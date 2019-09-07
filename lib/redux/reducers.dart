import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:redux/redux.dart';

/// Reducer
final Function appStateReducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, ActionStoreLocation>(_storeLocation),
  TypedReducer<AppState, ActionStoreHome>(_storeHome),
  TypedReducer<AppState, ActionAddProblem>(_addProblem),
  TypedReducer<AppState, ActionStoreNearbyStops>(_storeNearbyStopsWithTypes),
  TypedReducer<AppState, ActionStoreDepartures>(_storeDepartures),
]);

//
AppState _storeHome(AppState state, ActionStoreHome action) =>
    state.rebuild((b) => b..homeIndex = action.index);

AppState _addProblem(AppState state, ActionAddProblem action) =>
    state.rebuild((b) => b..problems.add(action.problem));

AppState _storeLocation(AppState state, ActionStoreLocation action) =>
    state.rebuild((b) => b
      ..location.latitude = action.location.latitude
      ..location.longitude = action.location.longitude
      ..location.timestamp = action.location.timestamp);

AppState _storeNearbyStopsWithTypes(
        AppState state, ActionStoreNearbyStops action) =>
    state.rebuild((b) => b..nearbyStops = action.nearbyStops.toBuilder());

AppState _storeDepartures(AppState state, ActionStoreDepartures action) =>
    state.rebuild((b) => b..departures = action.response.toBuilder());
