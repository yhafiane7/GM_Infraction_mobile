/// Simple test data for common use cases
class TestData {
  /// Sample Agent data
  static const Map<String, dynamic> sampleAgent = {
    'id': 1,
    'nom': 'Doe',
    'prenom': 'John',
    'tel': '1234567890',
    'cin': 'AB123456',
    'created_at': '2024-01-01T00:00:00Z',
    'updated_at': '2024-01-01T00:00:00Z',
  };

  /// Sample Categorie data
  static const Map<String, dynamic> sampleCategorie = {
    'id': 1,
    'nom': 'TestCategorie',
    'degre': 1,
    'created_at': '2024-01-01T00:00:00Z',
    'updated_at': '2024-01-01T00:00:00Z',
  };

  /// Sample Commune data
  static const Map<String, dynamic> sampleCommune = {
    'id': 1,
    'pachalik-circon': 'Test Pachalik',
    'caidat': 'Test Caidat',
    'nom': 'Test Commune',
    'latitude': '33.5731',
    'longitude': '-7.5898',
    'created_at': '2024-01-01T00:00:00Z',
    'updated_at': '2024-01-01T00:00:00Z',
  };

  /// Sample Violant data
  static const Map<String, dynamic> sampleViolant = {
    'id': 1,
    'nom': 'Violant',
    'prenom': 'Test',
    'cin': 'VI123456',
    'created_at': '2024-01-01T00:00:00Z',
    'updated_at': '2024-01-01T00:00:00Z',
  };

  /// Sample Infraction data
  static const Map<String, dynamic> sampleInfraction = {
    'id': 1,
    'nom': 'Test Infraction',
    'date': '2024-01-01',
    'adresse': 'Test Address',
    'commune_id': '1',
    'violant_id': '1',
    'agent_id': '1',
    'categorie_id': '1',
    'latitude': '33.5731',
    'longitude': '-7.5898',
    'created_at': '2024-01-01T00:00:00Z',
    'updated_at': '2024-01-01T00:00:00Z',
  };

  /// Sample Decision data
  static const Map<String, dynamic> sampleDecision = {
    'id': 1,
    'date': '2024-01-01',
    'decisionprise': 'Test Decision',
    'infraction_id': '1',
    'created_at': '2024-01-01T00:00:00Z',
    'updated_at': '2024-01-01T00:00:00Z',
  };

  /// Sample API response for agent list
  static const String validAgentListResponse = '''
  [
    {
      "id": 1,
      "nom": "Doe",
      "prenom": "John",
      "tel": "1234567890",
      "cin": "AB123456",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    },
    {
      "id": 2,
      "nom": "Smith",
      "prenom": "Jane",
      "tel": "0987654321",
      "cin": "CD789012",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    }
  ]
  ''';

  /// Sample success response for agent creation
  static const String validAgentCreateResponse = '''
  {
    "message": "Agent created successfully",
    "data": {
      "id": 1,
      "nom": "Doe",
      "prenom": "John",
      "tel": "1234567890",
      "cin": "AB123456",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    }
  }
  ''';

  /// Sample single agent JSON
  static const Map<String, dynamic> validAgentJson = {
    "id": 1,
    "nom": "Doe",
    "prenom": "John",
    "tel": "1234567890",
    "cin": "AB123456",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  };

  /// Sample validation error response
  static const String validationErrorResponse = '''
  {
    "message": "Validation failed",
    "errors": {
      "nom": ["The nom field is required."],
      "tel": ["The tel field must be exactly 10 characters."]
    }
  }
  ''';
}
