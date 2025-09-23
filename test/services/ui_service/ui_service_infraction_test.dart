import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import '../../test_helpers/toast_mock.dart';

void main() {
  group('UiService Infraction Operations', () {
    setUpAll(() async {
      await ToastMock.setUp();
    });

    tearDownAll(() async {
      await ToastMock.tearDown();
    });

    test('buildInfractionList returns a List<Infraction>', () async {
      final items = await UiService.buildInfractionList();
      expect(items, isA<List<Infraction>>());
    });

    test('performInfractionCreate returns String message', () async {
      final item = Infraction(
        nom: 'I',
        date: DateTime.now().toIso8601String(),
        adresse: 'A',
        commune_id: 1,
        violant_id: 1,
        agent_id: 1,
        categorie_id: 1,
        latitude: 0,
        longitude: 0,
      );
      final result = await UiService.performInfractionCreate(item);
      expect(result, isA<String>());
    });

    test('performInfractionUpdate returns String message', () async {
      final item = Infraction(
        id: 1,
        nom: 'I',
        date: DateTime.now().toIso8601String(),
        adresse: 'A',
        commune_id: 1,
        violant_id: 1,
        agent_id: 1,
        categorie_id: 1,
        latitude: 0,
        longitude: 0,
      );
      final result = await UiService.performInfractionUpdate(1, item);
      expect(result, isA<String>());
    });

    test('performInfractionDelete returns String message', () async {
      final item = Infraction(
        id: 1,
        nom: 'I',
        date: DateTime.now().toIso8601String(),
        adresse: 'A',
        commune_id: 1,
        violant_id: 1,
        agent_id: 1,
        categorie_id: 1,
        latitude: 0,
        longitude: 0,
      );
      final result = await UiService.performInfractionDelete(1, item);
      expect(result, isA<String>());
    });
  });
}


