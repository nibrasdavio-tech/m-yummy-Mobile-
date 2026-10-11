import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:m_yummy/main.dart';

void main() {
  testWidgets('App should render full-screen SplashScreen on startup',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MYummyApp());

    // Verify that the full screen image is displayed.
    expect(find.byType(Image), findsOneWidget);
  });
}
