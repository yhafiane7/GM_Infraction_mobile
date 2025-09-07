import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/page_base.dart';

void main() {
  group('Page Base Tests', () {
    testWidgets('BasePage should display correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const BasePage(title: 'Test Title'),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('BasePage should have add button in app bar',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const BasePage(title: 'Test Title'),
        ),
      );

      expect(find.byIcon(Icons.add_circle), findsOneWidget);
    });

    testWidgets('BasePage should have refresh indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const BasePage(title: 'Test Title'),
        ),
      );

      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('buildtheList should return FutureBuilder',
        (WidgetTester tester) async {
      final futureBuilder = buildtheList('Agent');

      expect(futureBuilder, isA<FutureBuilder<List<dynamic>>>());
    });

    testWidgets('buildtheList should handle loading state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: buildtheList('Agent'),
          ),
        ),
      );

      // Should show loading indicator initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    test('buildList should throw exception for invalid title', () async {
      expect(() => buildList('invalid'), throwsException);
    });

    testWidgets('BasePage should handle different titles',
        (WidgetTester tester) async {
      final titles = [
        'Agent',
        'Violant',
        'Categorie',
        'Commune',
        'Decision',
        'Infraction'
      ];

      for (final title in titles) {
        await tester.pumpWidget(
          MaterialApp(
            home: BasePage(title: title),
          ),
        );

        expect(find.text(title), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byIcon(Icons.add_circle), findsOneWidget);

        // Clean up for next iteration
        await tester.pumpWidget(Container());
      }
    });
  });
}
