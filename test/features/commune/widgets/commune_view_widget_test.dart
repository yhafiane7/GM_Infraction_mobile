import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/commune/commune.dart';

void main() {
  group('CommuneViewWidget', () {
    testWidgets('shows app bar and form', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CommuneViewWidget(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Ajouter une Commune'), findsOneWidget);
      expect(find.byType(CommuneFormWidget), findsOneWidget);
    });
  });
}
