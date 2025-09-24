import 'package:flutter_test/flutter_test.dart';

/// Opens a Material date picker by tapping on [dateFieldFinder]
/// and confirms the selection (defaults to current displayed date)
/// by tapping the confirm button (defaults to 'OK').
///
/// This helper is robust to scrolling contexts; ensure the field is visible
/// before calling if needed.
Future<void> pickDateViaPicker(
  WidgetTester tester,
  Finder dateFieldFinder, {
  String confirmLabel = 'OK',
}) async {
  // Tap the date field to open the picker
  await tester.tap(dateFieldFinder);
  await tester.pumpAndSettle();

  // Tap the confirm button (usually 'OK')
  final confirm = find.text(confirmLabel);
  expect(confirm, findsOneWidget,
      reason: 'Confirm button "$confirmLabel" not found');
  await tester.tap(confirm);
  await tester.pumpAndSettle();
}
