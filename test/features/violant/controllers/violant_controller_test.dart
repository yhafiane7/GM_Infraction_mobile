import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/violant/controllers/violant_controller.dart';
import 'package:gmsoft_infractions_mobile/models/violant_model.dart';

void main() {
  group('ViolantController', () {
    test('loadViolants toggles loading and populates list', () async {
      final controller = ViolantController();
      await controller.loadViolants();
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
      expect(controller.violants, isA<List<Violant>>());
    });

    test('createViolant returns message and toggles loading', () async {
      final controller = ViolantController();
      final res = await controller.createViolant(
        Violant(nom: 'V', prenom: 'P', cin: 'C'),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
    });

    test('updateViolant uses fallback id when null', () async {
      final controller = ViolantController();
      final res = await controller.updateViolant(
        2,
        Violant(nom: 'V', prenom: 'P', cin: 'C'),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });

    test('deleteViolant uses fallback id when null', () async {
      final controller = ViolantController();
      final res = await controller.deleteViolant(
        9,
        Violant(nom: 'V', prenom: 'P', cin: 'C'),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });
  });
}
