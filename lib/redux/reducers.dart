import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:redux/redux.dart';

/// Reducer
final Function appStateReducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, ActionStoreLocation>(_storeLocation),
  TypedReducer<AppState, ActionSetHome>(_setHome),
  TypedReducer<AppState, ActionAddProblem>(_addProblem),
  TypedReducer<AppState, ActionStoreNearbyStops>(_storeNearbyStops),
]);

//
AppState _setHome(AppState state, ActionSetHome action) =>
    state.rebuild((b) => b..homeIndex = action.index);

AppState _addProblem(AppState state, ActionAddProblem action) =>
    state.rebuild((b) => b..problems.add(action.problem));

AppState _storeLocation(AppState state, ActionStoreLocation action) =>
    state.rebuild((b) => b
      ..location.latitude = action.location.latitude
      ..location.longitude = action.location.longitude
      ..location.timestamp = action.location.timestamp);

AppState _storeNearbyStops(AppState state, ActionStoreNearbyStops action) =>
    state.rebuild((b) => b..stopsByDistance = action.response.toBuilder());
