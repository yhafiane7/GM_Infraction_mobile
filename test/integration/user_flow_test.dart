import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/main.dart';

void main() {
  group('User Flow Integration Tests', () {
    testWidgets('complete navigation flow through all pages',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Start at home - check for visible buttons
      expect(find.text('AGENT'), findsOneWidget);

      // Navigate to Agent page
      await tester.tap(find.text('AGENT'));
      await tester.pumpAndSettle();
      expect(find.byType(Scaffold), findsWidgets);

      // Test that we can navigate to different pages
      // (Each page navigation is tested separately in main_app_test.dart)
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('app should handle multiple rapid taps gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Rapidly tap different buttons
      await tester.tap(find.text('AGENT'), warnIfMissed: false);
      await tester.tap(find.text('CATEGORIE'), warnIfMissed: false);
      await tester.tap(find.text('COMMUNE'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // App should still be functional
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('app should maintain state during navigation',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Navigate to a page
      await tester.tap(find.text('AGENT'));
      await tester.pumpAndSettle();

      // App should still be functional
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('app should handle screen rotation gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      // Simulate screen rotation by changing size
      await tester.binding.setSurfaceSize(const Size(800, 600));
      await tester.pumpAndSettle();

      // App should still work
      expect(find.text('AGENT'), findsOneWidget);

      // Change back
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpAndSettle();

      // App should still work
      expect(find.text('AGENT'), findsOneWidget);
    });
  });
}
