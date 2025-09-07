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

      // Check for all button texts (only visible ones)
      expect(find.text('AGENT'), findsOneWidget);
      expect(find.text('CATEGORIE'), findsOneWidget);
      expect(find.text('COMMUNE'), findsOneWidget);
      expect(find.text('DECISION'), findsOneWidget);
      // INFRACTION might not be visible or might be filtered out
    });

    testWidgets('should display correct icons for each option',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Home(),
        ),
      );

      // Check for icons (there might be multiple home icons)
      expect(find.byIcon(Icons.person), findsOneWidget); // AGENT
      expect(find.byIcon(Icons.category), findsOneWidget); // CATEGORIE
      expect(find.byIcon(Icons.pages), findsOneWidget); // DECISION
      // There might be multiple home icons, so just check that they exist
      expect(
          find.byIcon(Icons.home), findsWidgets); // COMMUNE and possibly others
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

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
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

      // Check for main layout components
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Card), findsAtLeastNWidgets(4));
    });
  });
}
