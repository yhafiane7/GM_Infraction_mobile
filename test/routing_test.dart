import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/routing.dart' as routing;
import 'package:gmsoft_infractions_mobile/main.dart' as app;
import 'package:gmsoft_infractions_mobile/home.dart';
import 'package:gmsoft_infractions_mobile/page_base.dart';

void main() {
  group('Routing Tests', () {
    testWidgets('AppRouting should create correct routes',
        (WidgetTester tester) async {
      // Create a test context
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final routes = routing.AppRouting.main(context);

                // Test that routes map is created
                expect(
                    routes, isA<Map<String, Widget Function(BuildContext)>>());

                // Test specific routes exist
                expect(routes.containsKey('/'), isTrue);
                expect(routes.containsKey('/agent'), isTrue);
                expect(routes.containsKey('/violant'), isTrue);
                expect(routes.containsKey('/categorie'), isTrue);
                expect(routes.containsKey('/commune'), isTrue);
                expect(routes.containsKey('/decision'), isTrue);
                expect(routes.containsKey('/infraction'), isTrue);
                expect(routes.containsKey('/agent/create'), isTrue);
                expect(routes.containsKey('/commune/create'), isTrue);
                expect(routes.containsKey('/violant/create'), isTrue);
                expect(routes.containsKey('/categorie/create'), isTrue);
                expect(routes.containsKey('/decision/create'), isTrue);
                expect(routes.containsKey('/infraction/create'), isTrue);

                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('Home route should return Home widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final routes = routing.AppRouting.main(context);
                final homeWidget = routes['/']!(context);

                expect(homeWidget, isA<Home>());
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('Agent route should return BasePage with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final routes = routing.AppRouting.main(context);
                final agentWidget = routes['/agent']!(context);

                expect(agentWidget, isA<BasePage>());
                final basePage = agentWidget as BasePage;
                expect(basePage.title, equals('Agent'));
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('Violant route should return BasePage with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final routes = routing.AppRouting.main(context);
                final violantWidget = routes['/violant']!(context);

                expect(violantWidget, isA<BasePage>());
                final basePage = violantWidget as BasePage;
                expect(basePage.title, equals('Violant'));
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('Categorie route should return BasePage with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final routes = routing.AppRouting.main(context);
                final categorieWidget = routes['/categorie']!(context);

                expect(categorieWidget, isA<BasePage>());
                final basePage = categorieWidget as BasePage;
                expect(basePage.title, equals('Categorie'));
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('Commune route should return BasePage with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final routes = routing.AppRouting.main(context);
                final communeWidget = routes['/commune']!(context);

                expect(communeWidget, isA<BasePage>());
                final basePage = communeWidget as BasePage;
                expect(basePage.title, equals('Commune'));
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('Decision route should return BasePage with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final routes = routing.AppRouting.main(context);
                final decisionWidget = routes['/decision']!(context);

                expect(decisionWidget, isA<BasePage>());
                final basePage = decisionWidget as BasePage;
                expect(basePage.title, equals('Decision'));
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('Infraction route should return BasePage with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final routes = routing.AppRouting.main(context);
                final infractionWidget = routes['/infraction']!(context);

                expect(infractionWidget, isA<BasePage>());
                final basePage = infractionWidget as BasePage;
                expect(basePage.title, equals('Infraction'));
                return Container();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('InfractionView route should return FutureBuilder',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final routes = routing.AppRouting.main(context);
                final infractionViewWidget =
                    routes['/infraction/create']!(context);

                expect(
                    infractionViewWidget, isA<FutureBuilder<List<dynamic>>>());
                return Container();
              },
            ),
          ),
        ),
      );
    });

    test('routeName should return lowercase class name', () {
      // Test the routeName function
      final route = routing.routeName<Home>();
      expect(route, equals('home'));
    });

    test('createRouteWithName should create MapEntry', () {
      // Test the createRouteWithName function
      final entry =
          routing.createRouteWithName<Home>((context) => const Home());

      expect(entry, isA<MapEntry<String, routing.Builder<Widget>>>());
      expect(entry.key, equals('home'));
      expect(entry.value, isA<Function>());
    });

    testWidgets('Main MyApp should build MaterialApp',
        (WidgetTester tester) async {
      await tester.pumpWidget(app.MyApp());

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Main MyApp should have non-empty routes',
        (WidgetTester tester) async {
      await tester.pumpWidget(app.MyApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.routes,
          isA<Map<String, Widget Function(BuildContext)>>());
      expect(materialApp.routes!.isNotEmpty, isTrue);
    });
  });
}
