import 'dart:async';

import 'package:flutter/widgets.dart';

class QuestioningWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      (Zone.current.parent[#i_am_in_a_test] == true)
          ? Text('this is a test')
          : Text('this is not a test');
}
