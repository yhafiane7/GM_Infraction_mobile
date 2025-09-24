import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/violant/violant.dart';

void main() {
  group('ViolantViewWidget', () {
    testWidgets('shows app bar and form', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ViolantViewWidget(),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Ajouter un Violant'), findsOneWidget);
      expect(find.byType(ViolantFormWidget), findsOneWidget);
    });
  });
}
