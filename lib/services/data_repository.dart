import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';
import 'package:gmsoft_infractions_mobile/models/commune_model.dart';
import 'package:gmsoft_infractions_mobile/models/decision_model.dart';
import 'package:gmsoft_infractions_mobile/models/infraction_model.dart';
import 'package:gmsoft_infractions_mobile/models/violant_model.dart';
import 'api_client.dart';

class DataRepository {
  //------------------------------------Agent Operations-------------------------------------------------------//
  static Future<List<Agent>> fetchAgents() async {
    return await ApiClient.fetchData<Agent>(
        endpoint: 'agent', fromJson: (json) => Agent.fromJson(json));
  }

  static Future<Agent> getAgent(int index) async {
    return await ApiClient.getData<Agent>(
        endpoint: 'agent',
        index: index,
        fromJson: (json) => Agent.fromJson(json));
  }

  static Future<String> createAgent(Agent agent) async {
    return await ApiClient.postData<Agent>(endpoint: 'agent', object: agent);
  }

  static Future<String> updateAgent(int index, Agent agent) async {
    return await ApiClient.updateData<Agent>(
        endpoint: 'agent', index: index, object: agent);
  }

  static Future<String> deleteAgent(int index, Agent agent) async {
    return await ApiClient.deleteData<Agent>(
        endpoint: 'agent', index: index, object: agent);
  }

  //------------------------------------Commune Operations-------------------------------------------------------//
  static Future<List<Commune>> fetchCommunes() async {
    return await ApiClient.fetchData<Commune>(
        endpoint: 'commune', fromJson: (json) => Commune.fromJson(json));
  }

  static Future<Commune> getCommune(int index) async {
    return await ApiClient.getData<Commune>(
        endpoint: 'commune',
        index: index,
        fromJson: (json) => Commune.fromJson(json));
  }

  static Future<String> createCommune(Commune commune) async {
    return await ApiClient.postData<Commune>(
        endpoint: 'commune', object: commune);
  }

  static Future<String> updateCommune(int index, Commune commune) async {
    return await ApiClient.updateData<Commune>(
        endpoint: 'commune', index: index, object: commune);
  }

  static Future<String> deleteCommune(int index, Commune commune) async {
    return await ApiClient.deleteData<Commune>(
        endpoint: 'commune', index: index, object: commune);
  }

  //------------------------------------Categorie Operations-------------------------------------------------------//
  static Future<List<Categorie>> fetchCategories() async {
    return await ApiClient.fetchData<Categorie>(
        endpoint: 'categorie', fromJson: (json) => Categorie.fromJson(json));
  }

  static Future<Categorie> getCategorie(int index) async {
    return await ApiClient.getData<Categorie>(
        endpoint: 'categorie',
        index: index,
        fromJson: (json) => Categorie.fromJson(json));
  }

  static Future<String> createCategorie(Categorie categorie) async {
    return await ApiClient.postData<Categorie>(
        endpoint: 'categorie', object: categorie);
  }

  static Future<String> updateCategorie(int index, Categorie categorie) async {
    return await ApiClient.updateData<Categorie>(
        endpoint: 'categorie', index: index, object: categorie);
  }

  static Future<String> deleteCategorie(int index, Categorie categorie) async {
    return await ApiClient.deleteData<Categorie>(
        endpoint: 'categorie', index: index, object: categorie);
  }

  //------------------------------------Infraction Operations-------------------------------------------------------//
  static Future<List<Infraction>> fetchInfractions() async {
    return await ApiClient.fetchData<Infraction>(
        endpoint: 'infraction', fromJson: (json) => Infraction.fromJson(json));
  }

  static Future<Infraction> getInfraction(int index) async {
    return await ApiClient.getData<Infraction>(
        endpoint: 'infraction',
        index: index,
        fromJson: (json) => Infraction.fromJson(json));
  }

  static Future<String> createInfraction(Infraction infraction) async {
    return await ApiClient.postData<Infraction>(
        endpoint: 'infraction', object: infraction);
  }

  static Future<String> updateInfraction(
      int index, Infraction infraction) async {
    return await ApiClient.updateData<Infraction>(
        endpoint: 'infraction', index: index, object: infraction);
  }

  static Future<String> deleteInfraction(
      int index, Infraction infraction) async {
    return await ApiClient.deleteData<Infraction>(
        endpoint: 'infraction', index: index, object: infraction);
  }

  //------------------------------------Violant Operations-------------------------------------------------------//
  static Future<List<Violant>> fetchViolants() async {
    return await ApiClient.fetchData<Violant>(
        endpoint: 'violant', fromJson: (json) => Violant.fromJson(json));
  }

  static Future<Violant> getViolant(int index) async {
    return await ApiClient.getData<Violant>(
        endpoint: 'violant',
        index: index,
        fromJson: (json) => Violant.fromJson(json));
  }

  static Future<String> createViolant(Violant violant) async {
    return await ApiClient.postData<Violant>(
        endpoint: 'violant', object: violant);
  }

  static Future<String> updateViolant(int index, Violant violant) async {
    return await ApiClient.updateData<Violant>(
        endpoint: 'violant', index: index, object: violant);
  }

  static Future<String> deleteViolant(int index, Violant violant) async {
    return await ApiClient.deleteData<Violant>(
        endpoint: 'violant', index: index, object: violant);
  }

  //------------------------------------Decision Operations-------------------------------------------------------//
  static Future<List<Decision>> fetchDecisions() async {
    return await ApiClient.fetchData<Decision>(
        endpoint: 'decision', fromJson: (json) => Decision.fromJson(json));
  }

  static Future<Decision> getDecision(int index) async {
    return await ApiClient.getData<Decision>(
        endpoint: 'decision',
        index: index,
        fromJson: (json) => Decision.fromJson(json));
  }

  static Future<String> createDecision(Decision decision) async {
    return await ApiClient.postData<Decision>(
        endpoint: 'decision', object: decision);
  }

  static Future<String> updateDecision(int index, Decision decision) async {
    return await ApiClient.updateData<Decision>(
        endpoint: 'decision', index: index, object: decision);
  }

  static Future<String> deleteDecision(int index, Decision decision) async {
    return await ApiClient.deleteData<Decision>(
        endpoint: 'decision', index: index, object: decision);
  }
}
