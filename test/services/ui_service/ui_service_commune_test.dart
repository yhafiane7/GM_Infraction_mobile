import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import '../../test_helpers/toast_mock.dart';

void main() {
  group('UiService Commune Operations', () {
    setUpAll(() async {
      await ToastMock.setUp();
    });

    tearDownAll(() async {
      await ToastMock.tearDown();
    });

    test('buildCommuneList returns a List<Commune>', () async {
      final communes = await UiService.buildCommuneList();
      expect(communes, isA<List<Commune>>());
    });

    test('performCommuneCreate returns String message', () async {
      final commune = Commune(
        pachalikcircon: 'P',
        caidat: 'C',
        nom: 'N',
        latitude: 1,
        longitude: 1,
      );
      final result = await UiService.performCommuneCreate(commune);
      expect(result, isA<String>());
    });

    test('performCommuneUpdate returns String message', () async {
      final commune = Commune(
        pachalikcircon: 'P',
        caidat: 'C',
        nom: 'N',
        latitude: 1,
        longitude: 1,
      );
      final result = await UiService.performCommuneUpdate(1, commune);
      expect(result, isA<String>());
    });

    test('performCommuneDelete returns String message', () async {
      final commune = Commune(
        pachalikcircon: 'P',
        caidat: 'C',
        nom: 'N',
        latitude: 1,
        longitude: 1,
      );
      final result = await UiService.performCommuneDelete(1, commune);
      expect(result, isA<String>());
    });
  });
}
