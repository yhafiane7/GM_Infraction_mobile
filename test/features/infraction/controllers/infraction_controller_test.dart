import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/infraction/controllers/infraction_controller.dart';
import 'package:gmsoft_infractions_mobile/models/infraction_model.dart';

void main() {
  group('InfractionController', () {
    test('loadInfractions toggles loading and populates list', () async {
      final controller = InfractionController();
      await controller.loadInfractions();
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
      expect(controller.infractions, isA<List<Infraction>>());
    });

    test('createInfraction returns message and toggles loading', () async {
      final controller = InfractionController();
      final res = await controller.createInfraction(
        Infraction(
          nom: 'I',
          date: DateTime.now().toIso8601String(),
          adresse: 'A',
          commune_id: 1,
          violant_id: 1,
          agent_id: 1,
          categorie_id: 1,
          latitude: 0,
          longitude: 0,
        ),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
    });

    test('updateInfraction uses fallback id when null', () async {
      final controller = InfractionController();
      final res = await controller.updateInfraction(
        6,
        Infraction(
          nom: 'I',
          date: DateTime.now().toIso8601String(),
          adresse: 'A',
          commune_id: 1,
          violant_id: 1,
          agent_id: 1,
          categorie_id: 1,
          latitude: 0,
          longitude: 0,
        ),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });

    test('deleteInfraction uses fallback id when null', () async {
      final controller = InfractionController();
      final res = await controller.deleteInfraction(
        8,
        Infraction(
          nom: 'I',
          date: DateTime.now().toIso8601String(),
          adresse: 'A',
          commune_id: 1,
          violant_id: 1,
          agent_id: 1,
          categorie_id: 1,
          latitude: 0,
          longitude: 0,
        ),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });
  });
}
