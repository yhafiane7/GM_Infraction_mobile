import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/services/service_base.dart'; 
import '../models/commune_model.dart';
import 'package:http/http.dart' as http; 


Future<List<Commune>> getCommunes() async {
  // Fetch the data from your data source and parse it into a list of Commune objects
  final List<Commune> communes = await ServiceBase.fetchData<Commune>(
    http.Client(),
    'commune',
    (json) => Commune.fromJson(json),
  );
  return communes;
}

// Function to get the list of violants
Future<List<Violant>> getViolants() async {
  // Fetch the data from your data source and parse it into a list of Violant objects
  final List<Violant> violants = await ServiceBase.fetchData<Violant>(
    http.Client(),
    'violant',
    (json) => Violant.fromJson(json),
  );

  return violants;
}

// Function to get the list of agents
Future<List<Agent>> getAgents() async {
  // Fetch the data from your data source and parse it into a list of Agent objects
  final List<Agent> agents = await ServiceBase.fetchData<Agent>(
    http.Client(),
    'agent',
    (json) => Agent.fromJson(json),
  ); 
  return agents;
}

// Function to get the list of categories
Future<List<Categorie>> getCategories() async {
  // Fetch the data from your data source and parse it into a list of Categorie objects
  final List<Categorie> categories = await ServiceBase.fetchData<Categorie>(
    http.Client(),
    'categorie',
    (json) => Categorie.fromJson(json),
  ); 
  return categories;
}






