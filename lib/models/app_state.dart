import 'package:ptv_clone/models/location.dart';
import 'package:ptv_clone/models/problem.dart';
import 'package:quiver/core.dart';

/// The [AppState] holds the state of the entire app.
///
/// [homeIndex] is an index for the current home page.
/// [problems] is a list of [Problem] obejcts that the app can observe and
/// deal with in whatever way is appropriate.
class AppState {
  const AppState({this.homeIndex, this.problems, this.location});

  final int homeIndex;
  final List<Problem> problems;
  final Location location;

  static AppState initialState() => AppState(homeIndex: 0, problems: []);

  AppState copyWith(
      {int homeIndex, List<Problem> problems, Location location}) {
    return AppState(
      homeIndex: homeIndex ?? this.homeIndex,
      problems: problems ?? this.problems,
      location: location ?? this.location,
    );
  }

  @override
  int get hashCode => hash3(homeIndex, problems, location);

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          homeIndex == other.homeIndex &&
          problems == other.problems &&
          location == other.location;

  @override
  String toString() {
    return 'AppState{homIndex: $homeIndex, problems: $problems, location: $location}';
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'homeIndex': homeIndex,
        'problems': problems,
        'location': location,
      };
}
