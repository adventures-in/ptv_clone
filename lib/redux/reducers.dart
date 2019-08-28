import 'package:ptv_clone/models/built_app_state.dart';
import 'package:ptv_clone/redux/actions.dart';
import 'package:redux/redux.dart';

/// Reducer
final Function appStateReducer =
    combineReducers<BuiltAppState>(<Reducer<BuiltAppState>>[
  TypedReducer<BuiltAppState, ActionStoreLocation>(_storeLocation),
  TypedReducer<BuiltAppState, ActionSetHome>(_setHome),
  TypedReducer<BuiltAppState, ActionAddProblem>(_addProblem),
]);

//
BuiltAppState _setHome(BuiltAppState state, ActionSetHome action) =>
    state.rebuild((b) => b..homeIndex = action.index);

BuiltAppState _addProblem(BuiltAppState state, ActionAddProblem action) =>
    state.rebuild((b) => b..problems.add(action.problem));

BuiltAppState _storeLocation(BuiltAppState state, ActionStoreLocation action) =>
    state.rebuild((b) => b
      ..location.latitude = action.latitude
      ..location.longitude = action.longitude
      ..location.timestamp = action.timestamp);
