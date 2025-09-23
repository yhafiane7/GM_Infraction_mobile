import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/home.dart';

void main() {
  group('Home Widget Tests', () {
    testWidgets('should display app bar with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );

      expect(find.text('Gestion Des Infractions'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should display all menu options', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );
      await tester.pumpAndSettle();

      // Ensure each tile is made visible before asserting
      await tester.dragUntilVisible(
        find.text('AGENT'),
        find.byType(Scrollable),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
      expect(find.text('AGENT'), findsOneWidget);

      await tester.dragUntilVisible(
        find.text('CATEGORIE'),
        find.byType(Scrollable),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
      expect(find.text('CATEGORIE'), findsOneWidget);

      await tester.dragUntilVisible(
        find.text('COMMUNE'),
        find.byType(Scrollable),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
      expect(find.text('COMMUNE'), findsOneWidget);

      await tester.dragUntilVisible(
        find.text('DECISION'),
        find.byType(Scrollable),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
      expect(find.text('DECISION'), findsOneWidget);
    });

    testWidgets('should display correct icons for each option',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );
      await tester.pumpAndSettle();

      // Make sure icons are visible before asserting
      await tester.dragUntilVisible(
        find.byIcon(Icons.person),
        find.byType(Scrollable),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.person), findsOneWidget); // AGENT

      await tester.dragUntilVisible(
        find.byIcon(Icons.category),
        find.byType(Scrollable),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.category), findsOneWidget); // CATEGORIE

      await tester.dragUntilVisible(
        find.byIcon(Icons.pages),
        find.byType(Scrollable),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.pages), findsOneWidget); // DECISION

      expect(find.byIcon(Icons.home), findsWidgets); // COMMUNE and VIOLANT
    });

    testWidgets('should have correct number of menu buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );

      // Should have at least 4 buttons (some might be filtered out)
      expect(find.byType(Card), findsAtLeastNWidgets(4));
    });

    testWidgets('should display dashboard view', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should have tappable buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Home(),
        ),
      );

      // Check that buttons are tappable (InkWell widgets exist)
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('should have proper layout structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );
      await tester.pumpAndSettle();

      // Check for main layout components
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(Card), findsAtLeastNWidgets(4));
    });
  });
}
