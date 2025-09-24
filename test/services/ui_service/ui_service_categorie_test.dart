import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/ui_service.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';
import '../../test_helpers/toast_mock.dart';

void main() {
  group('UiService Categorie Operations', () {
    setUpAll(() async {
      await ToastMock.setUp();
    });

    tearDownAll(() async {
      await ToastMock.tearDown();
    });

    test('buildCategorieList returns a List<Categorie>', () async {
      final items = await UiService.buildCategorieList();
      expect(items, isA<List<Categorie>>());
    });

    test('performCategorieCreate returns String message', () async {
      final item = Categorie(nom: 'Cat', degre: 1);
      final result = await UiService.performCategorieCreate(item);
      expect(result, isA<String>());
    });

    test('performCategorieUpdate returns String message', () async {
      final item = Categorie(id: 1, nom: 'Cat', degre: 2);
      final result = await UiService.performCategorieUpdate(1, item);
      expect(result, isA<String>());
    });

    test('performCategorieDelete returns String message', () async {
      final item = Categorie(id: 1, nom: 'Cat', degre: 1);
      final result = await UiService.performCategorieDelete(1, item);
      expect(result, isA<String>());
    });
  });
}
