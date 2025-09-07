import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'api_client.dart';

class DataRepository {
  //------------------------------------Agent Operations-------------------------------------------------------//
  static Future<List<Agent>> fetchAgents() async {
    return await ApiClient.fetchData<Agent>((json) => Agent.fromJson(json));
  }

  static Future<Agent> getAgent(int index) async {
    return await ApiClient.getData<Agent>(index, (json) => Agent.fromJson(json));
  }

  static Future<String> createAgent(Agent agent) async {
    return await ApiClient.postData<Agent>(agent);
  }

  static Future<String> updateAgent(int index, Agent agent) async {
    return await ApiClient.updateData<Agent>(index, agent);
  }

  static Future<String> deleteAgent(int index, Agent agent) async {
    return await ApiClient.deleteData<Agent>(index, agent);
  }

  //------------------------------------Commune Operations-------------------------------------------------------//
  static Future<List<Commune>> fetchCommunes() async {
    return await ApiClient.fetchData<Commune>((json) => Commune.fromJson(json));
  }

  static Future<Commune> getCommune(int index) async {
    return await ApiClient.getData<Commune>(index, (json) => Commune.fromJson(json));
  }

  static Future<String> createCommune(Commune commune) async {
    return await ApiClient.postData<Commune>(commune);
  }

  static Future<String> updateCommune(int index, Commune commune) async {
    return await ApiClient.updateData<Commune>(index, commune);
  }

  static Future<String> deleteCommune(int index, Commune commune) async {
    return await ApiClient.deleteData<Commune>(index, commune);
  }

  //------------------------------------Categorie Operations-------------------------------------------------------//
  static Future<List<Categorie>> fetchCategories() async {
    return await ApiClient.fetchData<Categorie>((json) => Categorie.fromJson(json));
  }

  static Future<Categorie> getCategorie(int index) async {
    return await ApiClient.getData<Categorie>(index, (json) => Categorie.fromJson(json));
  }

  static Future<String> createCategorie(Categorie categorie) async {
    return await ApiClient.postData<Categorie>(categorie);
  }

  static Future<String> updateCategorie(int index, Categorie categorie) async {
    return await ApiClient.updateData<Categorie>(index, categorie);
  }

  static Future<String> deleteCategorie(int index, Categorie categorie) async {
    return await ApiClient.deleteData<Categorie>(index, categorie);
  }

  //------------------------------------Infraction Operations-------------------------------------------------------//
  static Future<List<Infraction>> fetchInfractions() async {
    return await ApiClient.fetchData<Infraction>((json) => Infraction.fromJson(json));
  }

  static Future<Infraction> getInfraction(int index) async {
    return await ApiClient.getData<Infraction>(index, (json) => Infraction.fromJson(json));
  }

  static Future<String> createInfraction(Infraction infraction) async {
    return await ApiClient.postData<Infraction>(infraction);
  }

  static Future<String> updateInfraction(int index, Infraction infraction) async {
    return await ApiClient.updateData<Infraction>(index, infraction);
  }

  static Future<String> deleteInfraction(int index, Infraction infraction) async {
    return await ApiClient.deleteData<Infraction>(index, infraction);
  }

  //------------------------------------Violant Operations-------------------------------------------------------//
  static Future<List<Violant>> fetchViolants() async {
    return await ApiClient.fetchData<Violant>((json) => Violant.fromJson(json));
  }

  static Future<Violant> getViolant(int index) async {
    return await ApiClient.getData<Violant>(index, (json) => Violant.fromJson(json));
  }

  static Future<String> createViolant(Violant violant) async {
    return await ApiClient.postData<Violant>(violant);
  }

  static Future<String> updateViolant(int index, Violant violant) async {
    return await ApiClient.updateData<Violant>(index, violant);
  }

  static Future<String> deleteViolant(int index, Violant violant) async {
    return await ApiClient.deleteData<Violant>(index, violant);
  }

  //------------------------------------Decision Operations-------------------------------------------------------//
  static Future<List<Decision>> fetchDecisions() async {
    return await ApiClient.fetchData<Decision>((json) => Decision.fromJson(json));
  }

  static Future<Decision> getDecision(int index) async {
    return await ApiClient.getData<Decision>(index, (json) => Decision.fromJson(json));
  }

  static Future<String> createDecision(Decision decision) async {
    return await ApiClient.postData<Decision>(decision);
  }

  static Future<String> updateDecision(int index, Decision decision) async {
    return await ApiClient.updateData<Decision>(index, decision);
  }

  static Future<String> deleteDecision(int index, Decision decision) async {
    return await ApiClient.deleteData<Decision>(index, decision);
  }
}