import 'package:meta/meta.dart';
import 'package:ptv_clone/models/app_state.dart';

/// An error or self reported problem, for adding to the [Redux.store]
///
/// [copyWith()] and overriding [==()] for state based equality are
/// intentionally not implemented as a [Problem] should never change and so
/// identity based equality is appropriate.
class Problem {
  const Problem(
      {@required this.type,
      @required this.message,
      this.trace,
      this.state,
      this.info});

  final ProblemType type;
  final String message;
  final StackTrace trace;
  final AppState state;
  final Map<String, dynamic> info;

  @override
  String toString() {
    return 'Problem{type: $type, message: $message, trace: $trace, state: $state, info: $info}';
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'message': message,
        'info': info,
      };
}

enum ProblemType {
  listenToAuthState,
  signout,
}
