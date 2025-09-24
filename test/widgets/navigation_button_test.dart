import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/models/button_option.dart';
import 'package:gmsoft_infractions_mobile/widgets/home_button.dart';

void main() {
  group('HomeButton Widget Tests', () {
    testWidgets('should display button with text and icon',
        (WidgetTester tester) async {
      const buttonOption = ButtonOption(
        route: '/test',
        text: 'Test Button',
        iconData: Icons.home,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeButton(buttonOption: buttonOption),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should display button without icon when iconData is null',
        (WidgetTester tester) async {
      const buttonOption = ButtonOption(
        route: '/test',
        text: 'Test Button',
        iconData: null,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeButton(buttonOption: buttonOption),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets('should display subText when provided',
        (WidgetTester tester) async {
      const buttonOption = ButtonOption(
        route: '/test',
        text: 'Test Button',
        subText: 'Sub text here',
        iconData: Icons.home,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeButton(buttonOption: buttonOption),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.text('Sub text here'), findsOneWidget);
    });

    testWidgets('should handle tap navigation', (WidgetTester tester) async {
      const buttonOption = ButtonOption(
        route: '/test',
        text: 'Test Button',
        iconData: Icons.home,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeButton(buttonOption: buttonOption),
          ),
          routes: {
            '/test': (context) => const Scaffold(body: Text('Test Page')),
          },
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(find.text('Test Page'), findsOneWidget);
    });

    testWidgets('should not navigate when route is null',
        (WidgetTester tester) async {
      const buttonOption = ButtonOption(
        route: null,
        text: 'Test Button',
        iconData: Icons.home,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeButton(buttonOption: buttonOption),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Should still be on the same page
      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('should adapt to small screen size',
        (WidgetTester tester) async {
      const buttonOption = ButtonOption(
        route: '/test',
        text: 'Test Button',
        iconData: Icons.home,
      );

      await tester.binding.setSurfaceSize(const Size(400, 800)); // Small screen
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeButton(buttonOption: buttonOption),
          ),
        ),
      );

      // Check that the button is displayed correctly
      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('should adapt to large screen size',
        (WidgetTester tester) async {
      const buttonOption = ButtonOption(
        route: '/test',
        text: 'Test Button',
        iconData: Icons.home,
      );

      await tester.binding
          .setSurfaceSize(const Size(1200, 800)); // Large screen
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeButton(buttonOption: buttonOption),
          ),
        ),
      );

      // Check that the button is displayed correctly
      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('generateMenu should create list of HomeButton widgets',
        (WidgetTester tester) async {
      const options = [
        ButtonOption(route: '/test1', text: 'Test 1', iconData: Icons.home),
        ButtonOption(route: '/test2', text: 'Test 2', iconData: Icons.person),
      ];

      final widgets = HomeButton.generateMenu(options);

      expect(widgets.length, equals(2));
      expect(widgets.every((widget) => widget is HomeButton), isTrue);
    });
  });
}
