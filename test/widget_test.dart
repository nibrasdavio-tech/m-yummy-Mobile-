import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:home/main.dart';

void main() {
  testWidgets('App should render full-screen SplashScreen on startup',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyummyApp());

    // Verify that the full screen image is displayed.
    expect(find.byType(Image), findsOneWidget);
  });
}