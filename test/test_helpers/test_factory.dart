import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';

/// Centralized test data factory for creating consistent test objects
class TestFactory {
  static String _uniqueId() => DateTime.now().millisecondsSinceEpoch.toString();

  // Sample JSON data
  static const Map<String, dynamic> sampleAgentJson = {
    'id': 1,
    'nom': 'Doe',
    'prenom': 'John',
    'tel': '1234567890',
    'cin': 'AB123456',
  };

  static const Map<String, dynamic> sampleAgentJsonWithoutId = {
    'nom': 'Doe',
    'prenom': 'John',
    'tel': '1234567890',
    'cin': 'AB123456',
  };

  static const Map<String, dynamic> sampleAgentJsonWithTimestamps = {
    'id': 1,
    'nom': 'Doe',
    'prenom': 'John',
    'tel': '1234567890',
    'cin': 'AB123456',
    'created_at': '2024-01-01T00:00:00Z',
    'updated_at': '2024-01-01T00:00:00Z',
  };

  // Agent factory methods
  static Agent createAgent({String? suffix}) {
    return Agent(
      id: 1,
      nom: 'Doe$suffix',
      prenom: 'John$suffix',
      tel: '1234567890',
      cin: 'AB123456',
    );
  }

  static List<Agent> createAgentList(int count) {
    return List.generate(count, (index) => createAgent(suffix: '_$index'));
  }

  static AgentBuilder agentBuilder() => AgentBuilder();

  // Commune factory methods
  static Commune createCommune({String? suffix}) {
    return Commune(
      id: 1,
      nom: 'TestCommune$suffix',
      pachalikcircon: 'TestPachalik$suffix',
      caidat: 'TestCaidat$suffix',
      latitude: 33.5731,
      longitude: -7.5898,
    );
  }

  static List<Commune> createCommuneList(int count) {
    return List.generate(count, (index) => createCommune(suffix: '_$index'));
  }

  // Categorie factory methods
  static Categorie createCategorie({String? suffix, int? degre}) {
    return Categorie(
      id: 1,
      nom: 'TestCategorie$suffix',
      degre: degre ?? 1,
    );
  }

  static List<Categorie> createCategorieList(int count) {
    return List.generate(
        count, (index) => createCategorie(suffix: '_$index', degre: index + 1));
  }

  // Violant factory methods
  static Violant createViolant({String? suffix}) {
    return Violant(
      id: 1,
      nom: 'TestViolant$suffix',
      prenom: 'TestPrenom$suffix',
      cin: 'TEST$suffix',
    );
  }

  static List<Violant> createViolantList(int count) {
    return List.generate(count, (index) => createViolant(suffix: '_$index'));
  }

  // Infraction factory methods
  static Infraction createInfraction({String? suffix}) {
    return Infraction(
      id: 1,
      nom: 'TestInfraction$suffix',
      date: DateTime.now().toIso8601String(),
      adresse: 'TestAdresse$suffix',
      commune_id: 1,
      violant_id: 1,
      agent_id: 1,
      categorie_id: 1,
      latitude: 33.5731,
      longitude: -7.5898,
    );
  }

  static List<Infraction> createInfractionList(int count) {
    return List.generate(count, (index) => createInfraction(suffix: '_$index'));
  }

  // Decision factory methods
  static Decision createDecision({String? suffix, int? infractionId}) {
    return Decision(
      id: 1,
      date: DateTime.now().toIso8601String(),
      decisionPrise: 'TestDecision$suffix',
      infractionId: infractionId ?? 1,
    );
  }

  static List<Decision> createDecisionList(int count) {
    return List.generate(count,
        (index) => createDecision(suffix: '_$index', infractionId: index + 1));
  }
}

/// Builder pattern for Agent objects
class AgentBuilder {
  int? _id;
  String _nom = 'Default';
  String _prenom = 'Agent';
  String _tel = '1234567890';
  String _cin = 'DEFAULT123';

  AgentBuilder withId(int id) {
    _id = id;
    return this;
  }

  AgentBuilder withName(String nom) {
    _nom = nom;
    return this;
  }

  AgentBuilder withPrenom(String prenom) {
    _prenom = prenom;
    return this;
  }

  AgentBuilder withTel(String tel) {
    _tel = tel;
    return this;
  }

  AgentBuilder withCin(String cin) {
    _cin = cin;
    return this;
  }

  Agent build() {
    return Agent(
      id: _id,
      nom: _nom,
      prenom: _prenom,
      tel: _tel,
      cin: _cin,
    );
  }
}

/// Builder pattern for Infraction objects
class InfractionBuilder {
  int? _id;
  String _nom = 'Default';
  String _date = DateTime.now().toIso8601String();
  String _adresse = 'Default Address';
  int _communeId = 1;
  int _violantId = 1;
  int _agentId = 1;
  int _categorieId = 1;
  double _latitude = 33.5731;
  double _longitude = -7.5898;

  InfractionBuilder withId(int id) {
    _id = id;
    return this;
  }

  InfractionBuilder withName(String nom) {
    _nom = nom;
    return this;
  }

  InfractionBuilder withDate(String date) {
    _date = date;
    return this;
  }

  InfractionBuilder withAdresse(String adresse) {
    _adresse = adresse;
    return this;
  }

  InfractionBuilder withCommuneId(int communeId) {
    _communeId = communeId;
    return this;
  }

  InfractionBuilder withViolantId(int violantId) {
    _violantId = violantId;
    return this;
  }

  InfractionBuilder withAgentId(int agentId) {
    _agentId = agentId;
    return this;
  }

  InfractionBuilder withCategorieId(int categorieId) {
    _categorieId = categorieId;
    return this;
  }

  InfractionBuilder withCoordinates(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;
    return this;
  }

  Infraction build() {
    return Infraction(
      id: _id,
      nom: _nom,
      date: _date,
      adresse: _adresse,
      commune_id: _communeId,
      violant_id: _violantId,
      agent_id: _agentId,
      categorie_id: _categorieId,
      latitude: _latitude,
      longitude: _longitude,
    );
  }
}
