import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'data_repository.dart';

class UiService {
  //------------------------------------Agent UI Operations-------------------------------------------------------//
  static Future<List<Agent>> buildAgentList() async {
    try {
      return await DataRepository.fetchAgents();
    } catch (e) {
      _showErrorToast('Error fetching agents: $e');
      return [];
    }
  }

  static Future<String> performAgentCreate(Agent agent) async {
    try {
      return await DataRepository.createAgent(agent);
    } catch (e) {
      _showErrorToast('Error creating agent: $e');
      return 'Error creating agent';
    }
  }

  static Future<String> performAgentUpdate(int index, Agent agent) async {
    try {
      return await DataRepository.updateAgent(index, agent);
    } catch (e) {
      _showErrorToast('Error updating agent: $e');
      return 'Error updating agent';
    }
  }

  static Future<String> performAgentDelete(int index, Agent agent) async {
    try {
      return await DataRepository.deleteAgent(index, agent);
    } catch (e) {
      _showErrorToast('Error deleting agent: $e');
      return 'Error deleting agent';
    }
  }

  //------------------------------------Commune UI Operations-------------------------------------------------------//
  static Future<List<Commune>> buildCommuneList() async {
    try {
      return await DataRepository.fetchCommunes();
    } catch (e) {
      _showErrorToast('Error fetching communes: $e');
      return [];
    }
  }

  static Future<String> performCommuneCreate(Commune commune) async {
    try {
      return await DataRepository.createCommune(commune);
    } catch (e) {
      _showErrorToast('Error creating commune: $e');
      return 'Error creating commune';
    }
  }

  static Future<String> performCommuneUpdate(int index, Commune commune) async {
    try {
      return await DataRepository.updateCommune(index, commune);
    } catch (e) {
      _showErrorToast('Error updating commune: $e');
      return 'Error updating commune';
    }
  }

  static Future<String> performCommuneDelete(int index, Commune commune) async {
    try {
      return await DataRepository.deleteCommune(index, commune);
    } catch (e) {
      _showErrorToast('Error deleting commune: $e');
      return 'Error deleting commune';
    }
  }

  //------------------------------------Categorie UI Operations-------------------------------------------------------//
  static Future<List<Categorie>> buildCategorieList() async {
    try {
      return await DataRepository.fetchCategories();
    } catch (e) {
      _showErrorToast('Error fetching categories: $e');
      return [];
    }
  }

  static Future<String> performCategorieCreate(Categorie categorie) async {
    try {
      return await DataRepository.createCategorie(categorie);
    } catch (e) {
      _showErrorToast('Error creating category: $e');
      return 'Error creating category';
    }
  }

  static Future<String> performCategorieUpdate(
      int index, Categorie categorie) async {
    try {
      return await DataRepository.updateCategorie(index, categorie);
    } catch (e) {
      _showErrorToast('Error updating category: $e');
      return 'Error updating category';
    }
  }

  static Future<String> performCategorieDelete(
      int index, Categorie categorie) async {
    try {
      return await DataRepository.deleteCategorie(index, categorie);
    } catch (e) {
      _showErrorToast('Error deleting category: $e');
      return 'Error deleting category';
    }
  }

  //------------------------------------Infraction UI Operations-------------------------------------------------------//
  static Future<List<Infraction>> buildInfractionList() async {
    try {
      return await DataRepository.fetchInfractions();
    } catch (e) {
      _showErrorToast('Error fetching infractions: $e');
      return [];
    }
  }

  static Future<String> performInfractionCreate(Infraction infraction) async {
    try {
      return await DataRepository.createInfraction(infraction);
    } catch (e) {
      _showErrorToast('Error creating infraction: $e');
      return 'Error creating infraction';
    }
  }

  static Future<String> performInfractionUpdate(
      int index, Infraction infraction) async {
    try {
      return await DataRepository.updateInfraction(index, infraction);
    } catch (e) {
      _showErrorToast('Error updating infraction: $e');
      return 'Error updating infraction';
    }
  }

  static Future<String> performInfractionDelete(
      int index, Infraction infraction) async {
    try {
      return await DataRepository.deleteInfraction(index, infraction);
    } catch (e) {
      _showErrorToast('Error deleting infraction: $e');
      return 'Error deleting infraction';
    }
  }

  //------------------------------------Violant UI Operations-------------------------------------------------------//
  static Future<List<Violant>> buildViolantList() async {
    try {
      return await DataRepository.fetchViolants();
    } catch (e) {
      _showErrorToast('Error fetching violants: $e');
      return [];
    }
  }

  static Future<String> performViolantCreate(Violant violant) async {
    try {
      return await DataRepository.createViolant(violant);
    } catch (e) {
      _showErrorToast('Error creating violant: $e');
      return 'Error creating violant';
    }
  }

  static Future<String> performViolantUpdate(int index, Violant violant) async {
    try {
      return await DataRepository.updateViolant(index, violant);
    } catch (e) {
      _showErrorToast('Error updating violant: $e');
      return 'Error updating violant';
    }
  }

  static Future<String> performViolantDelete(int index, Violant violant) async {
    try {
      return await DataRepository.deleteViolant(index, violant);
    } catch (e) {
      _showErrorToast('Error deleting violant: $e');
      return 'Error deleting violant';
    }
  }

  //------------------------------------Decision UI Operations-------------------------------------------------------//
  static Future<List<Decision>> buildDecisionList() async {
    try {
      return await DataRepository.fetchDecisions();
    } catch (e) {
      _showErrorToast('Error fetching decisions: $e');
      return [];
    }
  }

  static Future<String> performDecisionCreate(Decision decision) async {
    try {
      return await DataRepository.createDecision(decision);
    } catch (e) {
      _showErrorToast('Error creating decision: $e');
      return 'Error creating decision';
    }
  }

  static Future<String> performDecisionUpdate(
      int index, Decision decision) async {
    try {
      return await DataRepository.updateDecision(index, decision);
    } catch (e) {
      _showErrorToast('Error updating decision: $e');
      return 'Error updating decision';
    }
  }

  static Future<String> performDecisionDelete(
      int index, Decision decision) async {
    try {
      return await DataRepository.deleteDecision(index, decision);
    } catch (e) {
      _showErrorToast('Error deleting decision: $e');
      return 'Error deleting decision';
    }
  }

  //------------------------------------UI Utility Methods-------------------------------------------------------//
  static InputDecoration buildInputDecoration(
      String hintText, IconData icon, Color color) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: color),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  static InputDecoration buildShowDecoration(
      String value, IconData icon, Color color) {
    return InputDecoration(
      labelText: value,
      prefixIcon: Icon(icon, color: color),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: 2),
      ),
    );
  }

  static List<Widget> buildTextFieldsEdit(
      List<String> fieldValuesIndicated,
      List<IconData> fieldIcons,
      List<Color> fieldColors,
      BuildContext context) {
    List<Widget> textFields = [];

    for (int i = 0; i < fieldValuesIndicated.length; i++) {
      textFields.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            fieldValuesIndicated[i],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: fieldColors[i],
            ),
          ),
        ),
      );
    }

    return textFields;
  }

  static List<Object> buildTextFieldsUpdate(
      List<String> fieldValues,
      List<IconData> fieldIcons,
      List<Color> fieldColors,
      BuildContext context) {
    List<Widget> inputFields = [];
    List<TextEditingController> controllers = [];

    for (int i = 0; i < fieldValues.length; i++) {
      TextEditingController controller =
          TextEditingController(text: fieldValues[i]);
      controllers.add(controller);

      inputFields.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            decoration: buildInputDecoration(
              'Entrer ${fieldValues[i]}',
              fieldIcons[i],
              fieldColors[i],
            ),
          ),
        ),
      );
    }

    return [inputFields, controllers];
  }

  //------------------------------------Utility Methods-------------------------------------------------------//
  static void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
