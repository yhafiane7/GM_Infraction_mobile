import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import '../../test_helpers/toast_mock.dart';

void main() {
  group('UiService Agent Operations', () {
    setUpAll(() async {
      await ToastMock.setUp();
    });

    tearDownAll(() async {
      await ToastMock.tearDown();
    });

    test('buildAgentList returns a List<Agent>', () async {
      final agents = await UiService.buildAgentList();
      expect(agents, isA<List<Agent>>());
    });

    test('performAgentCreate returns String message', () async {
      final agent = Agent(nom: 'A', prenom: 'B', tel: '0123456789', cin: 'X');
      final result = await UiService.performAgentCreate(agent);
      expect(result, isA<String>());
    });

    test('performAgentUpdate returns String message', () async {
      final agent = Agent(nom: 'A', prenom: 'B', tel: '0123456789', cin: 'X');
      final result = await UiService.performAgentUpdate(1, agent);
      expect(result, isA<String>());
    });

    test('performAgentDelete returns String message', () async {
      final agent = Agent(nom: 'A', prenom: 'B', tel: '0123456789', cin: 'X');
      final result = await UiService.performAgentDelete(1, agent);
      expect(result, isA<String>());
    });
  });
}
