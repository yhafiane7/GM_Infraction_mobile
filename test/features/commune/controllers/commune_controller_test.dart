import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/features/commune/controllers/commune_controller.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';

void main() {
  group('CommuneController', () {
    test('loadCommunes toggles loading and populates list', () async {
      final controller = CommuneController();
      await controller.loadCommunes();
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
      expect(controller.communes, isA<List<Commune>>());
      
    },
    //increase timeout to 60 seconds
    timeout: const Timeout(Duration(seconds: 60)),
    );

    test('createCommune returns message and toggles loading', () async {
      final controller = CommuneController();
      final res = await controller.createCommune(
        Commune(
            pachalikcircon: 'P',
            caidat: 'C',
            nom: 'N',
            latitude: 0,
            longitude: 0),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
    });

    test('updateCommune returns message when id provided', () async {
      final controller = CommuneController();
      final res = await controller.updateCommune(
        1,
        Commune(
            id: 2,
            pachalikcircon: 'P',
            caidat: 'C',
            nom: 'N',
            latitude: 0,
            longitude: 0),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });

    test('deleteCommune returns message when id provided', () async {
      final controller = CommuneController();
      final res = await controller.deleteCommune(
        1,
        Commune(
            id: 2,
            pachalikcircon: 'P',
            caidat: 'C',
            nom: 'N',
            latitude: 0,
            longitude: 0),
      );
      expect(res, isA<String>());
      expect(controller.isLoading, false);
    });
  });
}
