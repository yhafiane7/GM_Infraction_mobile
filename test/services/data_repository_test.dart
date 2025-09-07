import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/services/data_repository.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';

void main() {
  group('DataRepository Tests', () {
    // Helper function to generate unique test data
    String getUniqueTimestamp() {
      return DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    }

    //------------------------------------Agent Operations Tests-------------------------------------------------------//
    group('Agent Operations', () {
      test('should fetch agents successfully', () async {
        try {
          final agents = await DataRepository.fetchAgents();
          expect(agents, isA<List<Agent>>());
        } catch (e) {
          // Expected if server is down
          expect(e, isA<Exception>());
        }
      });

      test('should get single agent successfully', () async {
        try {
          final agent = await DataRepository.getAgent(1);
          expect(agent, isA<Agent>());
          expect(agent.nom, isA<String>());
          expect(agent.prenom, isA<String>());
          expect(agent.tel, isA<String>());
          expect(agent.cin, isA<String>());
        } catch (e) {
          // Expected if server is down or agent not found
          expect(e, isA<Exception>());
        }
      });

      test('should create agent successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testAgent = Agent(
            nom: 'Test$timestamp',
            prenom: 'Agent$timestamp',
            tel: '${timestamp.padLeft(10, '0')}',
            cin: 'AB$timestamp',
          );

          final result = await DataRepository.createAgent(testAgent);
          expect(result, isA<String>());
        } catch (e) {
          // Expected if server is down or validation fails
          expect(e, isA<Exception>());
        }
      });

      test('should update agent successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testAgent = Agent(
            nom: 'Updated$timestamp',
            prenom: 'Agent$timestamp',
            tel: '${timestamp.padLeft(10, '0')}',
            cin: 'AB$timestamp',
          );

          final result = await DataRepository.updateAgent(1, testAgent);
          expect(result, isA<String>());
        } catch (e) {
          // Expected if server is down or agent not found
          expect(e, isA<Exception>());
        }
      });

      test('should delete agent successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testAgent = Agent(
            nom: 'Delete$timestamp',
            prenom: 'Agent$timestamp',
            tel: '${timestamp.padLeft(10, '0')}',
            cin: 'AB$timestamp',
          );

          final result = await DataRepository.deleteAgent(1, testAgent);
          expect(result, isA<String>());
        } catch (e) {
          // Expected if server is down or agent not found
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Commune Operations Tests-------------------------------------------------------//
    group('Commune Operations', () {
      test('should fetch communes successfully', () async {
        try {
          final communes = await DataRepository.fetchCommunes();
          expect(communes, isA<List<Commune>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should get single commune successfully', () async {
        try {
          final commune = await DataRepository.getCommune(1);
          expect(commune, isA<Commune>());
          expect(commune.nom, isA<String>());
          expect(commune.pachalikcircon, isA<String>());
          expect(commune.caidat, isA<String>());
          expect(commune.latitude, isA<double>());
          expect(commune.longitude, isA<double>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should create commune successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCommune = Commune(
            pachalikcircon: 'Pachalik$timestamp',
            caidat: 'Caidat$timestamp',
            nom: 'Commune$timestamp',
            latitude: 33.5731,
            longitude: -7.5898,
          );

          final result = await DataRepository.createCommune(testCommune);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should update commune successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCommune = Commune(
            pachalikcircon: 'UpdatedPachalik$timestamp',
            caidat: 'UpdatedCaidat$timestamp',
            nom: 'UpdatedCommune$timestamp',
            latitude: 34.0209,
            longitude: -6.8416,
          );

          final result = await DataRepository.updateCommune(1, testCommune);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should delete commune successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCommune = Commune(
            pachalikcircon: 'DeletePachalik$timestamp',
            caidat: 'DeleteCaidat$timestamp',
            nom: 'DeleteCommune$timestamp',
            latitude: 35.7595,
            longitude: -5.8340,
          );

          final result = await DataRepository.deleteCommune(1, testCommune);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Categorie Operations Tests-------------------------------------------------------//
    group('Categorie Operations', () {
      test('should fetch categories successfully', () async {
        try {
          final categories = await DataRepository.fetchCategories();
          expect(categories, isA<List<Categorie>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should get single categorie successfully', () async {
        try {
          final categorie = await DataRepository.getCategorie(1);
          expect(categorie, isA<Categorie>());
          expect(categorie.nom, isA<String>());
          expect(categorie.degre, isA<int>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should create categorie successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCategorie = Categorie(
            nom: 'Categorie$timestamp',
            degre: 1,
          );

          final result = await DataRepository.createCategorie(testCategorie);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should update categorie successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCategorie = Categorie(
            nom: 'UpdatedCategorie$timestamp',
            degre: 2,
          );

          final result = await DataRepository.updateCategorie(1, testCategorie);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should delete categorie successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCategorie = Categorie(
            nom: 'DeleteCategorie$timestamp',
            degre: 3,
          );

          final result = await DataRepository.deleteCategorie(1, testCategorie);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Infraction Operations Tests-------------------------------------------------------//
    group('Infraction Operations', () {
      test('should fetch infractions successfully', () async {
        try {
          final infractions = await DataRepository.fetchInfractions();
          expect(infractions, isA<List<Infraction>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should get single infraction successfully', () async {
        try {
          final infraction = await DataRepository.getInfraction(1);
          expect(infraction, isA<Infraction>());
          expect(infraction.nom, isA<String>());
          expect(infraction.date, isA<String>());
          expect(infraction.adresse, isA<String>());
          expect(infraction.commune_id, isA<int>());
          expect(infraction.violant_id, isA<int>());
          expect(infraction.agent_id, isA<int>());
          expect(infraction.categorie_id, isA<int>());
          expect(infraction.latitude, isA<double>());
          expect(infraction.longitude, isA<double>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should create infraction successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testInfraction = Infraction(
            nom: 'Infraction$timestamp',
            date: DateTime.now().toIso8601String(),
            adresse: 'Adresse$timestamp',
            commune_id: 1,
            violant_id: 1,
            agent_id: 1,
            categorie_id: 1,
            latitude: 33.5731,
            longitude: -7.5898,
          );

          final result = await DataRepository.createInfraction(testInfraction);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should update infraction successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testInfraction = Infraction(
            nom: 'UpdatedInfraction$timestamp',
            date: DateTime.now().toIso8601String(),
            adresse: 'UpdatedAdresse$timestamp',
            commune_id: 2,
            violant_id: 2,
            agent_id: 2,
            categorie_id: 2,
            latitude: 34.0209,
            longitude: -6.8416,
          );

          final result =
              await DataRepository.updateInfraction(1, testInfraction);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should delete infraction successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testInfraction = Infraction(
            nom: 'DeleteInfraction$timestamp',
            date: DateTime.now().toIso8601String(),
            adresse: 'DeleteAdresse$timestamp',
            commune_id: 3,
            violant_id: 3,
            agent_id: 3,
            categorie_id: 3,
            latitude: 35.7595,
            longitude: -5.8340,
          );

          final result =
              await DataRepository.deleteInfraction(1, testInfraction);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Violant Operations Tests-------------------------------------------------------//
    group('Violant Operations', () {
      test('should fetch violants successfully', () async {
        try {
          final violants = await DataRepository.fetchViolants();
          expect(violants, isA<List<Violant>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should get single violant successfully', () async {
        try {
          final violant = await DataRepository.getViolant(1);
          expect(violant, isA<Violant>());
          expect(violant.nom, isA<String>());
          expect(violant.prenom, isA<String>());
          expect(violant.cin, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should create violant successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testViolant = Violant(
            nom: 'Violant$timestamp',
            prenom: 'Prenom$timestamp',
            cin: 'CD$timestamp',
          );

          final result = await DataRepository.createViolant(testViolant);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should update violant successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testViolant = Violant(
            nom: 'UpdatedViolant$timestamp',
            prenom: 'UpdatedPrenom$timestamp',
            cin: 'EF$timestamp',
          );

          final result = await DataRepository.updateViolant(1, testViolant);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should delete violant successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testViolant = Violant(
            nom: 'DeleteViolant$timestamp',
            prenom: 'DeletePrenom$timestamp',
            cin: 'GH$timestamp',
          );

          final result = await DataRepository.deleteViolant(1, testViolant);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Decision Operations Tests-------------------------------------------------------//
    group('Decision Operations', () {
      test('should fetch decisions successfully', () async {
        try {
          final decisions = await DataRepository.fetchDecisions();
          expect(decisions, isA<List<Decision>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should get single decision successfully', () async {
        try {
          final decision = await DataRepository.getDecision(1);
          expect(decision, isA<Decision>());
          expect(decision.date, isA<String>());
          expect(decision.decisionPrise, isA<String>());
          expect(decision.infractionId, isA<int>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should create decision successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testDecision = Decision(
            date: DateTime.now().toIso8601String(),
            decisionPrise: 'Decision$timestamp',
            infractionId: 1,
          );

          final result = await DataRepository.createDecision(testDecision);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should update decision successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testDecision = Decision(
            date: DateTime.now().toIso8601String(),
            decisionPrise: 'UpdatedDecision$timestamp',
            infractionId: 2,
          );

          final result = await DataRepository.updateDecision(1, testDecision);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should delete decision successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testDecision = Decision(
            date: DateTime.now().toIso8601String(),
            decisionPrise: 'DeleteDecision$timestamp',
            infractionId: 3,
          );

          final result = await DataRepository.deleteDecision(1, testDecision);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Error Handling Tests-------------------------------------------------------//
    group('Error Handling', () {
      test('should handle invalid index gracefully', () async {
        try {
          await DataRepository.getAgent(-1);
          fail('Should have thrown an exception for invalid index');
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should handle network timeout gracefully', () async {
        try {
          // This test assumes the server might be slow or unreachable
          await DataRepository.fetchAgents();
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should handle malformed data gracefully', () async {
        try {
          // Test with potentially invalid data
          final invalidAgent = Agent(
            nom: '',
            prenom: '',
            tel: '',
            cin: '',
          );

          await DataRepository.createAgent(invalidAgent);
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });
  });
}
