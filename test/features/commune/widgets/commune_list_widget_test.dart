import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/commune/commune.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
// Removed unnecessary direct controller import; available via commune.dart barrel

void main() {
  group('CommuneListWidget', () {
    final testCommunes = [
      Commune(
          id: 10,
          nom: 'C1',
          caidat: 'Ca1',
          pachalikcircon: 'Pa1',
          latitude: 1.1,
          longitude: 2.2),
      Commune(
          id: 11,
          nom: 'C2',
          caidat: 'Ca2',
          pachalikcircon: 'Pa2',
          latitude: 3.3,
          longitude: 4.4),
      Commune(
          id: 12,
          nom: 'C3',
          caidat: 'Ca3',
          pachalikcircon: 'Pa3',
          latitude: 5.5,
          longitude: 6.6),
    ];

    testWidgets('displays table headers and rows', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommuneListWidget(
              communes: testCommunes,
              controller: CommuneController(),
            ),
          ),
        ),
      );

      expect(find.text('ID'), findsOneWidget);
      expect(find.text('Nom'), findsOneWidget);
      expect(find.text('Caidat'), findsOneWidget);
      expect(find.text('Pachalik/Circon'), findsOneWidget);
      expect(find.text('Latitude'), findsOneWidget);
      expect(find.text('Longitude'), findsOneWidget);

      expect(find.text('C1'), findsOneWidget);
      expect(find.text('C2'), findsOneWidget);
      expect(find.text('C3'), findsOneWidget);
    });

    testWidgets('handles empty list without controller',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CommuneListWidget(communes: []),
          ),
        ),
      );

      expect(find.byType(DataTable), findsOneWidget);
      expect(find.text('ID'), findsOneWidget);
    });

    testWidgets('long press opens details dialog when controller provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CommuneListWidget(
              communes: testCommunes,
              controller: CommuneController(),
            ),
          ),
        ),
      );

      await tester.longPress(find.text('C1'));
      await tester.pumpAndSettle();

      expect(find.text('Nom: C1'), findsOneWidget);
      expect(find.text('Caidat: Ca1'), findsOneWidget);
      expect(find.text('Pachalik/Circon: Pa1'), findsOneWidget);
    });
  });
}
