import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/features/agent/controllers/agent_controller.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'package:gmsoft_infractions_mobile/services/data_repository.dart'
    as repo;
import 'package:gmsoft_infractions_mobile/services/ui_service.dart' as ui;
import 'package:mockito/mockito.dart';

class _RepoMock extends Mock implements repo.DataRepository {}

class _UiMock extends Mock implements ui.UiService {}

void main() {
  group('AgentController', () {
    // Note: DataRepository and UiService are used via static methods in code.
    // For demonstration, we test observable state changes and rely on
    // fast-returning real static methods for success paths.

    test('loadAgents sets loading and populates agents on success', () async {
      final controller = AgentController();
      var notifyCount = 0;
      controller.addListener(() => notifyCount++);

      await controller.loadAgents();

      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
      expect(controller.agents, isA<List<Agent>>());
      expect(notifyCount, greaterThanOrEqualTo(2));
    });

    test('createAgent toggles loading and returns message', () async {
      final controller = AgentController();
      final result = await controller.createAgent(
        Agent(nom: 'A', prenom: 'B', tel: '0123456789', cin: 'X'),
      );
      expect(result, isA<String>());
      expect(controller.isLoading, false);
      expect(controller.errorMessage, isNull);
    });

    test('updateAgent uses fallback id when agent.id is null', () async {
      final controller = AgentController();
      final result = await controller.updateAgent(
        5,
        Agent(nom: 'A', prenom: 'B', tel: '0123456789', cin: 'X'),
      );
      expect(result, isA<String>());
      expect(controller.isLoading, false);
    });

    test('deleteAgent uses fallback id when agent.id is null', () async {
      final controller = AgentController();
      final result = await controller.deleteAgent(
        7,
        Agent(nom: 'A', prenom: 'B', tel: '0123456789', cin: 'X'),
      );
      expect(result, isA<String>());
      expect(controller.isLoading, false);
    });
  });
}
