import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/commune/commune.dart';
// Removed unnecessary direct controller import; available via commune.dart barrel

void main() {
  group('CommuneFormWidget', () {
    testWidgets('renders form fields and submit button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommuneFormWidget(controller: CommuneController()),
          ),
        ),
      );

      expect(find.byType(Form), findsOneWidget);
      // 5 fields: Nom, Caidat, Pachalik/Circon, Latitude, Longitude
      expect(find.byType(TextFormField), findsNWidgets(5));
      expect(find.text('Ajouter'), findsOneWidget);
    });

    testWidgets('validates required and number fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommuneFormWidget(controller: CommuneController()),
          ),
        ),
      );

      // Submit without filling
      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('SVP entrer Le Nom'), findsOneWidget);
      expect(find.text('SVP entrer La Caidat'), findsOneWidget);
      expect(find.text('SVP entrer Le Pachalik/Circon'), findsOneWidget);
      expect(find.text('SVP entrer une latitude valide'), findsOneWidget);
      expect(find.text('SVP entrer une longitude valide'), findsOneWidget);
    });

    testWidgets('accepts input and shows confirmation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommuneFormWidget(controller: CommuneController()),
          ),
        ),
      );

      // Fill all fields
      await tester.enterText(find.byType(TextFormField).at(0), 'Commune A');
      await tester.enterText(find.byType(TextFormField).at(1), 'Caidat X');
      await tester.enterText(find.byType(TextFormField).at(2), 'Pachalik Y');
      await tester.enterText(find.byType(TextFormField).at(3), '12.34');
      await tester.enterText(find.byType(TextFormField).at(4), '-56.78');

      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('Confirmation'), findsOneWidget);
      expect(find.text('Commune Details:'), findsOneWidget);
      expect(find.text('Nom: Commune A'), findsOneWidget);
      expect(find.text('Caidat: Caidat X'), findsOneWidget);
      expect(find.text('Pachalik/Circon: Pachalik Y'), findsOneWidget);
      expect(find.text('Latitude: 12.34'), findsOneWidget);
      expect(find.text('Longitude: -56.78'), findsOneWidget);
    });

    testWidgets('latitude/longitude formatter allows digits, dot, minus',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommuneFormWidget(controller: CommuneController()),
          ),
        ),
      );

      final latField = find.byType(TextFormField).at(3);
      final lonField = find.byType(TextFormField).at(4);

      await tester.enterText(
          latField, '1a2b.3-4'); // filters to '12.3-4' (invalid)
      await tester.enterText(
          lonField, '78.9-1'); // already uses allowed chars but invalid

      // Attempt submit to trigger validators
      await tester.tap(find.text('Ajouter'));
      await tester.pumpAndSettle();

      expect(find.text('SVP entrer une latitude valide'), findsOneWidget);
      expect(find.text('SVP entrer une longitude valide'), findsOneWidget);
    });
  });
}
