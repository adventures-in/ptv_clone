import 'package:ptv_clone/models/problem.dart';
import 'package:quiver/core.dart';

/// The [AppState] holds the state of the entire app.
///
/// [homeIndex] is an index for the current home page.
/// [problems] is a list of [Problem] obejcts that the app can observe and
/// deal with in whatever way is appropriate.
class AppState {
  const AppState({this.homeIndex, this.problems});

  final int homeIndex;
  final List<Problem> problems;

  static AppState initialState() => AppState(homeIndex: 0, problems: []);

  AppState copyWith({int homeIndex, List<Problem> problems}) {
    return AppState(
        homeIndex: homeIndex ?? this.homeIndex,
        problems: problems ?? this.problems);
  }

  @override
  int get hashCode => hash2(homeIndex, problems);

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          homeIndex == other.homeIndex &&
          problems == other.problems;

  @override
  String toString() {
    return 'AppState{homIndex: $homeIndex, problems: $problems}';
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'homeIndex': homeIndex,
        'problems': problems,
      };
}
