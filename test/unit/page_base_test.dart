import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/page_base.dart';

void main() {
  group('Page Base Tests', () {
    testWidgets('BasePage should display correct title',
        (WidgetTester tester) async {
      // Arrange
      const testTitle = 'Test Title';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: const BasePage(title: testTitle),
        ),
      );

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('BasePage should have add button in app bar',
        (WidgetTester tester) async {
      // Arrange
      const testTitle = 'Test Title';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: const BasePage(title: testTitle),
        ),
      );

      // Assert
      expect(find.byIcon(Icons.add_circle), findsOneWidget);
    });

    testWidgets('BasePage should have refresh indicator',
        (WidgetTester tester) async {
      // Arrange
      const testTitle = 'Test Title';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: const BasePage(title: testTitle),
        ),
      );

      // Assert
      expect(find.byType(RefreshIndicator), findsOneWidget);
    });

    testWidgets('buildtheList should return FutureBuilder',
        (WidgetTester tester) async {
      // Act
      final futureBuilder = buildtheList('Agent');

      // Assert
      expect(futureBuilder, isA<FutureBuilder<List<dynamic>>>());
    });

    testWidgets('buildtheList should handle loading state',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: buildtheList('Agent'),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    test('buildList should throw exception for invalid title', () async {
      // Act & Assert
      expect(() => buildList('invalid'), throwsException);
    });

    testWidgets('BasePage should handle different titles',
        (WidgetTester tester) async {
      // Arrange
      const titles = [
        'Agent',
        'Violant',
        'Categorie',
        'Commune',
        'Decision',
        'Infraction'
      ];

      // Act & Assert
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

