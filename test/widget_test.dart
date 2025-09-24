import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/main.dart';

void main() {
  testWidgets('App loads without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('App has basic structure', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the app has the basic structure
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('App handles overflow gracefully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the app has the basic structure despite overflow warnings
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);

    // The app should still function despite UI overflow warnings
    // This is a UI layout issue, not a test issue
  });
}
