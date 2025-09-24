import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/categorie/controllers/categorie_controller.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';

void main() {
  group('CategorieController', () {
    test('createCategorie returns message and toggles loading', () async {
      final controller = CategorieController();
      final res =
          await controller.createCategorie(Categorie(nom: 'C', degre: 1));
      expect(res, isA<String>());
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
    });

    test('updateCategorie returns message when id provided', () async {
      final controller = CategorieController();
      final res = await controller.updateCategorie(
          1, Categorie(id: 2, nom: 'C', degre: 2));
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });

    test('deleteCategorie returns message when id provided', () async {
      final controller = CategorieController();
      final res = await controller.deleteCategorie(
          1, Categorie(id: 2, nom: 'C', degre: 1));
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });
  });
}
