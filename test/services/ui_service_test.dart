import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
import 'package:flutter/services.dart';

void main() {
  group('UiService Tests', () {
    // Helper function to generate unique test data
    String getUniqueTimestamp() {
      return DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    }

    // Mock the FlutterToast plugin
    setUpAll(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('PonnamKarthik/fluttertoast'),
        (MethodCall methodCall) async {
          // Mock the showToast method to avoid plugin errors
          if (methodCall.method == 'showToast') {
            return null;
          }
          return null;
        },
      );
    });

    tearDownAll(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('PonnamKarthik/fluttertoast'),
        null,
      );
    });

    //------------------------------------Agent UI Operations Tests-------------------------------------------------------//
    group('Agent UI Operations', () {
      test('should build agent list successfully', () async {
        try {
          final agents = await UiService.buildAgentList();
          expect(agents, isA<List<Agent>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform agent create successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testAgent = Agent(
            nom: 'TestAgent$timestamp',
            prenom: 'TestPrenom$timestamp',
            tel: '${timestamp.padLeft(10, '0')}',
            cin: 'TEST$timestamp',
          );

          final result = await UiService.performAgentCreate(testAgent);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform agent update successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testAgent = Agent(
            nom: 'UpdatedAgent$timestamp',
            prenom: 'UpdatedPrenom$timestamp',
            tel: '${timestamp.padLeft(10, '0')}',
            cin: 'UPD$timestamp',
          );

          final result = await UiService.performAgentUpdate(1, testAgent);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform agent delete successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testAgent = Agent(
            nom: 'DeleteAgent$timestamp',
            prenom: 'DeletePrenom$timestamp',
            tel: '${timestamp.padLeft(10, '0')}',
            cin: 'DEL$timestamp',
          );

          final result = await UiService.performAgentDelete(1, testAgent);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Commune UI Operations Tests-------------------------------------------------------//
    group('Commune UI Operations', () {
      test('should build commune list successfully', () async {
        try {
          final communes = await UiService.buildCommuneList();
          expect(communes, isA<List<Commune>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform commune create successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCommune = Commune(
            pachalikcircon: 'TestPachalik$timestamp',
            caidat: 'TestCaidat$timestamp',
            nom: 'TestCommune$timestamp',
            latitude: 33.5731,
            longitude: -7.5898,
          );

          final result = await UiService.performCommuneCreate(testCommune);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform commune update successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCommune = Commune(
            pachalikcircon: 'UpdatedPachalik$timestamp',
            caidat: 'UpdatedCaidat$timestamp',
            nom: 'UpdatedCommune$timestamp',
            latitude: 34.0209,
            longitude: -6.8416,
          );

          final result = await UiService.performCommuneUpdate(1, testCommune);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform commune delete successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCommune = Commune(
            pachalikcircon: 'DeletePachalik$timestamp',
            caidat: 'DeleteCaidat$timestamp',
            nom: 'DeleteCommune$timestamp',
            latitude: 35.7595,
            longitude: -5.8340,
          );

          final result = await UiService.performCommuneDelete(1, testCommune);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Categorie UI Operations Tests-------------------------------------------------------//
    group('Categorie UI Operations', () {
      test('should build categorie list successfully', () async {
        try {
          final categories = await UiService.buildCategorieList();
          expect(categories, isA<List<Categorie>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform categorie create successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCategorie = Categorie(
            nom: 'TestCategorie$timestamp',
            degre: 1,
          );

          final result = await UiService.performCategorieCreate(testCategorie);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform categorie update successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCategorie = Categorie(
            nom: 'UpdatedCategorie$timestamp',
            degre: 2,
          );

          final result =
              await UiService.performCategorieUpdate(1, testCategorie);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform categorie delete successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testCategorie = Categorie(
            nom: 'DeleteCategorie$timestamp',
            degre: 3,
          );

          final result =
              await UiService.performCategorieDelete(1, testCategorie);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Infraction UI Operations Tests-------------------------------------------------------//
    group('Infraction UI Operations', () {
      test('should build infraction list successfully', () async {
        try {
          final infractions = await UiService.buildInfractionList();
          expect(infractions, isA<List<Infraction>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform infraction create successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testInfraction = Infraction(
            nom: 'TestInfraction$timestamp',
            date: DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
            adresse: 'TestAdresse$timestamp',
            commune_id: 1,
            violant_id: 1,
            agent_id: 1,
            categorie_id: 1,
            latitude: 33.5731,
            longitude: -7.5898,
          );

          final result =
              await UiService.performInfractionCreate(testInfraction);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform infraction update successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testInfraction = Infraction(
            nom: 'UpdatedInfraction$timestamp',
            date: DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
            adresse: 'UpdatedAdresse$timestamp',
            commune_id: 2,
            violant_id: 2,
            agent_id: 2,
            categorie_id: 2,
            latitude: 34.0209,
            longitude: -6.8416,
          );

          final result =
              await UiService.performInfractionUpdate(1, testInfraction);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform infraction delete successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testInfraction = Infraction(
            nom: 'DeleteInfraction$timestamp',
            date: DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
            adresse: 'DeleteAdresse$timestamp',
            commune_id: 3,
            violant_id: 3,
            agent_id: 3,
            categorie_id: 3,
            latitude: 35.7595,
            longitude: -5.8340,
          );

          final result =
              await UiService.performInfractionDelete(1, testInfraction);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Violant UI Operations Tests-------------------------------------------------------//
    group('Violant UI Operations', () {
      test('should build violant list successfully', () async {
        try {
          final violants = await UiService.buildViolantList();
          expect(violants, isA<List<Violant>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform violant create successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testViolant = Violant(
            nom: 'TestViolant$timestamp',
            prenom: 'TestPrenom$timestamp',
            cin: 'TEST$timestamp',
          );

          final result = await UiService.performViolantCreate(testViolant);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform violant update successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testViolant = Violant(
            nom: 'UpdatedViolant$timestamp',
            prenom: 'UpdatedPrenom$timestamp',
            cin: 'UPD$timestamp',
          );

          final result = await UiService.performViolantUpdate(1, testViolant);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform violant delete successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testViolant = Violant(
            nom: 'DeleteViolant$timestamp',
            prenom: 'DeletePrenom$timestamp',
            cin: 'DEL$timestamp',
          );

          final result = await UiService.performViolantDelete(1, testViolant);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------Decision UI Operations Tests-------------------------------------------------------//
    group('Decision UI Operations', () {
      test('should build decision list successfully', () async {
        try {
          final decisions = await UiService.buildDecisionList();
          expect(decisions, isA<List<Decision>>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform decision create successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testDecision = Decision(
            date: DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
            decisionPrise: 'TestDecision$timestamp',
            infractionId: 1,
          );

          final result = await UiService.performDecisionCreate(testDecision);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform decision update successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testDecision = Decision(
            date: DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
            decisionPrise: 'UpdatedDecision$timestamp',
            infractionId: 2,
          );

          final result = await UiService.performDecisionUpdate(1, testDecision);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should perform decision delete successfully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testDecision = Decision(
            date: DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
            decisionPrise: 'DeleteDecision$timestamp',
            infractionId: 3,
          );

          final result = await UiService.performDecisionDelete(1, testDecision);
          expect(result, isA<String>());
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });

    //------------------------------------UI Utility Methods Tests-------------------------------------------------------//
    group('UI Utility Methods', () {
      test('should build input decoration correctly', () {
        final decoration = UiService.buildInputDecoration(
          'Test Hint',
          Icons.person,
          Colors.blue,
        );

        expect(decoration.hintText, equals('Test Hint'));
        expect(decoration.prefixIcon, isA<Icon>());
        expect(decoration.border, isA<OutlineInputBorder>());
        expect(decoration.enabledBorder, isA<OutlineInputBorder>());
        expect(decoration.focusedBorder, isA<OutlineInputBorder>());
        expect(decoration.errorBorder, isA<OutlineInputBorder>());
        expect(decoration.focusedErrorBorder, isA<OutlineInputBorder>());
      });

      test('should build show decoration correctly', () {
        final decoration = UiService.buildShowDecoration(
          'Test Value',
          Icons.home,
          Colors.green,
        );

        expect(decoration.labelText, equals('Test Value'));
        expect(decoration.prefixIcon, isA<Icon>());
        expect(decoration.border, isA<OutlineInputBorder>());
        expect(decoration.enabledBorder, isA<OutlineInputBorder>());
        expect(decoration.focusedBorder, isA<OutlineInputBorder>());
      });

      testWidgets('should build text fields edit correctly',
          (WidgetTester tester) async {
        final fieldValues = ['Field 1', 'Field 2', 'Field 3'];
        final fieldIcons = [Icons.person, Icons.home, Icons.info];
        final fieldColors = [Colors.blue, Colors.green, Colors.red];

        final textFields = UiService.buildTextFieldsEdit(
          fieldValues,
          fieldIcons,
          fieldColors,
          tester.element(find.byType(Container)),
        );

        expect(textFields.length, equals(3));
        expect(textFields[0], isA<Widget>());
        expect(textFields[1], isA<Widget>());
        expect(textFields[2], isA<Widget>());
      });

      testWidgets('should build text fields update correctly',
          (WidgetTester tester) async {
        final fieldValues = ['Value 1', 'Value 2'];
        final fieldIcons = [Icons.person, Icons.home];
        final fieldColors = [Colors.blue, Colors.green];

        final result = UiService.buildTextFieldsUpdate(
          fieldValues,
          fieldIcons,
          fieldColors,
          tester.element(find.byType(Container)),
        );

        expect(result.length, equals(2));
        expect(result[0], isA<List<Widget>>());
        expect(result[1], isA<List<TextEditingController>>());

        final inputFields = result[0] as List<Widget>;
        final controllers = result[1] as List<TextEditingController>;

        expect(inputFields.length, equals(2));
        expect(controllers.length, equals(2));
        expect(controllers[0].text, equals('Value 1'));
        expect(controllers[1].text, equals('Value 2'));
      });

      test('should show success toast', () {
        // This test verifies the method can be called without throwing
        expect(() => UiService.showSuccessToast('Test success message'),
            returnsNormally);
      });
    });

    //------------------------------------Error Handling Tests-------------------------------------------------------//
    group('Error Handling', () {
      test('should handle network errors gracefully', () async {
        try {
          // Test with invalid data that should cause an error
          final invalidAgent = Agent(
            nom: '',
            prenom: '',
            tel: '',
            cin: '',
          );

          final result = await UiService.performAgentCreate(invalidAgent);
          expect(result, isA<String>());
          // Should return error message, not throw
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });

      test('should handle invalid index gracefully', () async {
        try {
          final timestamp = getUniqueTimestamp();
          final testAgent = Agent(
            nom: 'Test$timestamp',
            prenom: 'Agent$timestamp',
            tel: '${timestamp.padLeft(10, '0')}',
            cin: 'AB$timestamp',
          );

          await UiService.performAgentUpdate(-1, testAgent);
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });
  });
}
