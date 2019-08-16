import 'package:ptv_clone/models/app_state.dart';
import 'package:ptv_clone/models/built_location.dart';
import 'package:ptv_clone/models/problem.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:redux/redux.dart';

/// Reducer
final Function appStateReducer = combineReducers<AppState>(<Reducer<AppState>>[
  TypedReducer<AppState, ActionStoreLocation>(_storeLocation),
  TypedReducer<AppState, ActionSetHome>(_setHome),
  TypedReducer<AppState, ActionAddProblem>(_addProblem),
]);

//
AppState _setHome(AppState state, ActionSetHome action) =>
    state.copyWith(homeIndex: action.index);

AppState _addProblem(AppState state, ActionAddProblem action) {
  // add to the list of problems
  final List<Problem> newProblems = <Problem>[action.problem] + state.problems;

  return state.copyWith(problems: newProblems);
}

AppState _storeLocation(AppState state, ActionStoreLocation action) {
  return state.copyWith(
      location: BuiltLocation((b) => b
        ..latitude = action.latitude
        ..longitude = action.longitude
        ..timestamp = action.timestamp));
}
