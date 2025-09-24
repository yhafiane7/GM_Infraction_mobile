import 'package:http/http.dart' as http;

/// Mock HTTP responses for testing
class MockResponses {
  //------------------------------------Agent Mock Responses---------------------------------------//
  /// Successful agent list response
  static http.Response successfulAgentList() {
    return http.Response('''[
      {"id":1,"nom":"Doe","prenom":"John","tel":"1234567890","cin":"AB123456","created_at":"2025-01-01T00:00:00Z","updated_at":"2025-01-01T00:00:00Z"},
      {"id":2,"nom":"Smith","prenom":"Jane","tel":"0987654321","cin":"CD789012","created_at":"2025-01-01T00:00:00Z","updated_at":"2025-01-01T00:00:00Z"}
    ]''', 200);
  }

  /// Successful agent creation response
  static http.Response successfulAgentCreation() {
    return http.Response(
        '''{"message":"Agent created successfully","data":{"id":1,"nom":"Doe","prenom":"John","tel":"1234567890","cin":"AB123456","created_at":"2025-01-01T00:00:00Z","updated_at":"2025-01-01T00:00:00Z"}}''',
        201);
  }

  /// Successful single agent response
  static http.Response successfulSingleAgent() {
    return http.Response(
        '{"id":1,"nom":"Doe","prenom":"John","tel":"1234567890","cin":"AB123456","created_at":"2025-01-01T00:00:00Z","updated_at":"2025-01-01T00:00:00Z"}',
        200);
  }

  /// Successful agent update response
  static http.Response successfulAgentUpdate() {
    return http.Response('{"message": "Agent updated successfully"}', 200);
  }

  /// Successful agent deletion response
  static http.Response successfulAgentDeletion() {
    return http.Response('{"message": "Agent deleted successfully"}', 200);
  }

  //------------------------------------Commune Mock Responses---------------------------------------//
  /// Successful commune list response
  static http.Response successfulCommuneList() {
    return http.Response('''[
      {"id":1,"nom":"TestCommune","pachalik-circon":"TestPachalik","caidat":"TestCaidat","latitude":33.5731,"longitude":-7.5898},
      {"id":2,"nom":"TestCommune2","pachalik-circon":"TestPachalik2","caidat":"TestCaidat2","latitude":34.0209,"longitude":-6.8416}
    ]''', 200);
  }

  /// Successful single commune response
  static http.Response successfulSingleCommune() {
    return http.Response(
        '{"id":1,"nom":"TestCommune","pachalik-circon":"TestPachalik","caidat":"TestCaidat","latitude":33.5731,"longitude":-7.5898}',
        200);
  }

  /// Successful commune creation response
  static http.Response successfulCommuneCreation() {
    return http.Response('{"message": "Commune created successfully"}', 201);
  }

  /// Successful commune update response
  static http.Response successfulCommuneUpdate() {
    return http.Response('{"message": "Commune updated successfully"}', 200);
  }

  /// Successful commune deletion response
  static http.Response successfulCommuneDeletion() {
    return http.Response('{"message": "Commune deleted successfully"}', 200);
  }

  //------------------------------------Categorie Mock Responses---------------------------------------//
  /// Successful categorie list response
  static http.Response successfulCategorieList() {
    return http.Response('''[
      {"id":1,"nom":"TestCategorie","degre":1},
      {"id":2,"nom":"TestCategorie2","degre":2}
    ]''', 200);
  }

  /// Successful single categorie response
  static http.Response successfulSingleCategorie() {
    return http.Response('{"id":1,"nom":"TestCategorie","degre":1}', 200);
  }

  /// Successful categorie creation response
  static http.Response successfulCategorieCreation() {
    return http.Response('{"message": "Categorie created successfully"}', 201);
  }

  /// Successful categorie update response
  static http.Response successfulCategorieUpdate() {
    return http.Response('{"message": "Categorie updated successfully"}', 200);
  }

  /// Successful categorie deletion response
  static http.Response successfulCategorieDeletion() {
    return http.Response('{"message": "Categorie deleted successfully"}', 200);
  }

  //------------------------------------Infraction Mock Responses---------------------------------------//
  /// Successful infraction list response
  static http.Response successfulInfractionList() {
    return http.Response('''[
      {"id":1,"nom":"TestInfraction","date":"2025-01-01T00:00:00Z","adresse":"TestAdresse","commune_id":1,"violant_id":1,"agent_id":1,"categorie_id":1,"latitude":33.5731,"longitude":-7.5898},
      {"id":2,"nom":"TestInfraction2","date":"2025-01-01T00:00:00Z","adresse":"TestAdresse2","commune_id":2,"violant_id":2,"agent_id":2,"categorie_id":2,"latitude":34.0209,"longitude":-6.8416}
    ]''', 200);
  }

  /// Successful single infraction response
  static http.Response successfulSingleInfraction() {
    return http.Response(
        '{"id":1,"nom":"TestInfraction","date":"2025-01-01T00:00:00Z","adresse":"TestAdresse","commune_id":1,"violant_id":1,"agent_id":1,"categorie_id":1,"latitude":33.5731,"longitude":-7.5898}',
        200);
  }

  /// Successful infraction creation response
  static http.Response successfulInfractionCreation() {
    return http.Response('{"message": "Infraction created successfully"}', 201);
  }

  /// Successful infraction update response
  static http.Response successfulInfractionUpdate() {
    return http.Response('{"message": "Infraction updated successfully"}', 200);
  }

  /// Successful infraction deletion response
  static http.Response successfulInfractionDeletion() {
    return http.Response('{"message": "Infraction deleted successfully"}', 200);
  }

  //------------------------------------Violant Mock Responses---------------------------------------//
  /// Successful violant list response
  static http.Response successfulViolantList() {
    return http.Response('''[
      {"id":1,"nom":"TestViolant","prenom":"TestPrenom","cin":"TEST123"},
      {"id":2,"nom":"TestViolant2","prenom":"TestPrenom2","cin":"TEST456"}
    ]''', 200);
  }

  /// Successful single violant response
  static http.Response successfulSingleViolant() {
    return http.Response(
        '{"id":1,"nom":"TestViolant","prenom":"TestPrenom","cin":"TEST123"}',
        200);
  }

  /// Successful violant creation response
  static http.Response successfulViolantCreation() {
    return http.Response('{"message": "Violant created successfully"}', 201);
  }

  /// Successful violant update response
  static http.Response successfulViolantUpdate() {
    return http.Response('{"message": "Violant updated successfully"}', 200);
  }

  /// Successful violant deletion response
  static http.Response successfulViolantDeletion() {
    return http.Response('{"message": "Violant deleted successfully"}', 200);
  }

  //------------------------------------Decision Mock Responses---------------------------------------//
  /// Successful decision list response
  static http.Response successfulDecisionList() {
    return http.Response('''[
      {"id":1,"date":"2025-01-01T00:00:00Z","decisionprise":"TestDecision","infraction_id":1},
      {"id":2,"date":"2025-01-01T00:00:00Z","decisionprise":"TestDecision2","infraction_id":2}
    ]''', 200);
  }

  /// Successful single decision response
  static http.Response successfulSingleDecision() {
    return http.Response(
        '{"id":1,"date":"2025-01-01T00:00:00Z","decisionprise":"TestDecision","infraction_id":1}',
        200);
  }

  /// Successful decision creation response
  static http.Response successfulDecisionCreation() {
    return http.Response('{"message": "Decision created successfully"}', 201);
  }

  /// Successful decision update response
  static http.Response successfulDecisionUpdate() {
    return http.Response('{"message": "Decision updated successfully"}', 200);
  }

  /// Successful decision deletion response
  static http.Response successfulDecisionDeletion() {
    return http.Response('{"message": "Decision deleted successfully"}', 200);
  }

  //------------------------------------Error Mock Responses---------------------------------------//
  /// Validation error response
  static http.Response validationError() {
    return http.Response(
        '''{"message":"Validation failed","errors":{"nom":["The nom field is required."],"tel":["The tel field must be exactly 10 characters."]}}''',
        400);
  }

  /// Server error response
  static http.Response serverError() {
    return http.Response('{"message": "Internal server error"}', 500);
  }

  /// Network error response
  static http.Response networkError() {
    return http.Response('', 500); // Simulates network failure
  }

  /// Not found response
  static http.Response notFound() {
    return http.Response('{"message": "Resource not found"}', 404);
  }
}
