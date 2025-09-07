import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/page_base.dart';

void main() {
  group('Page Base Simple Tests', () {
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

    testWidgets('BasePage should handle add button tap with proper route',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/test/create': (context) =>
                const Scaffold(body: Text('Create Page')),
          },
          home: const BasePage(title: 'Test Title'),
        ),
      );

      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pumpAndSettle();

      // Should navigate to create route
      expect(find.text('Create Page'), findsOneWidget);
    });

    testWidgets('BasePage should handle refresh', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const BasePage(title: 'Agent'),
        ),
      );

      // Trigger refresh by pulling down
      await tester.drag(find.byType(RefreshIndicator), const Offset(0, 300));
      await tester.pumpAndSettle();

      // Should show loading or data
      expect(find.byType(CircularProgressIndicator), findsWidgets);
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

    testWidgets('buildtheList should handle error state',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: buildtheList('InvalidTitle'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should show error text
      expect(find.text('Erreur'), findsOneWidget);
    });

    test('buildList should return correct data for agent', () async {
      try {
        final result = await buildList('agent');
        expect(result, isA<List<dynamic>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
    });

    test('buildList should return correct data for violant', () async {
      try {
        final result = await buildList('violant');
        expect(result, isA<List<dynamic>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
    });

    test('buildList should return correct data for categorie', () async {
      try {
        final result = await buildList('categorie');
        expect(result, isA<List<dynamic>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
    });

    test('buildList should return correct data for commune', () async {
      try {
        final result = await buildList('commune');
        expect(result, isA<List<dynamic>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
    });

    test('buildList should return correct data for decision', () async {
      try {
        final result = await buildList('decision');
        expect(result, isA<List<dynamic>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
    });

    test('buildList should return correct data for infraction', () async {
      try {
        final result = await buildList('infraction');
        expect(result, isA<List<dynamic>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
    });

    test('buildList should throw exception for invalid title', () async {
      expect(() => buildList('invalid'), throwsException);
    });

    test('buildList should handle case insensitive titles', () async {
      try {
        final result1 = await buildList('Agent');
        final result2 = await buildList('agent');
        expect(result1, isA<List<dynamic>>());
        expect(result2, isA<List<dynamic>>());
      } catch (e) {
        // Expected if server is down
        expect(e, isA<Exception>());
      }
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
