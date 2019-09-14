// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ptv_clone/widgets/questioning_widget.dart';

void main() {
  testWidgets('QuestioningWidget gets the right answer',
      (WidgetTester tester) async {
    await runZoned(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: QuestioningWidget(),
        ),
      ));
    }, zoneValues: <dynamic, bool>{#i_am_in_a_test: true});

    expect(find.text('this is a test'), findsOneWidget);
    expect(find.text('this is not a test'), findsNothing);
  });

  // runZoned(() {
  //   testWidgets('QuestioningWidget gets the right answer',
  //       (WidgetTester tester) async {
  //     await tester.pumpWidget(
  //       MaterialApp(
  //         home: Scaffold(
  //           body: QuestioningWidget(),
  //         ),
  //       ),
  //     );

  //     expect(find.text('this is a test'), findsOneWidget);
  //     expect(find.text('this is not a test'), findsNothing);
  //   });
  // }, zoneValues: <dynamic, bool>{#i_am_in_a_test: true});
}
