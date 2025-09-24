import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/ui_service.dart';
import 'package:gmsoft_infractions_mobile/models/violant_model.dart';
import '../../test_helpers/toast_mock.dart';

void main() {
  group('UiService Violant Operations', () {
    setUpAll(() async {
      await ToastMock.setUp();
    });

    tearDownAll(() async {
      await ToastMock.tearDown();
    });

    test('buildViolantList returns a List<Violant>', () async {
      final items = await UiService.buildViolantList();
      expect(items, isA<List<Violant>>());
    });

    test('performViolantCreate returns String message', () async {
      final item = Violant(nom: 'V', prenom: 'P', cin: 'C');
      final result = await UiService.performViolantCreate(item);
      expect(result, isA<String>());
    });

    test('performViolantUpdate returns String message', () async {
      final item = Violant(id: 1, nom: 'V', prenom: 'P', cin: 'C');
      final result = await UiService.performViolantUpdate(1, item);
      expect(result, isA<String>());
    });

    test('performViolantDelete returns String message', () async {
      final item = Violant(id: 1, nom: 'V', prenom: 'P', cin: 'C');
      final result = await UiService.performViolantDelete(1, item);
      expect(result, isA<String>());
    });
  });
}
