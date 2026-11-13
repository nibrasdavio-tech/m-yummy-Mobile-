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

  testWidgets(
      'HomePage displays chat icon next to notification icon and navigates to ChatAdminScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // Verify both icons exist in the dashboard
    expect(find.byIcon(Icons.chat_outlined), findsWidgets);
    expect(find.byIcon(Icons.notifications_active), findsOneWidget);

    // Tap chat icon in header
    await tester.tap(find.byIcon(Icons.chat_outlined).first);
    await tester.pumpAndSettle();

    // Verify ChatAdminScreen is opened
    expect(find.text('Chat dengan Admin'), findsOneWidget);
  });
}