// This file now serves as a test suite runner for all data repository tests
// Individual entity tests are in separate files for better organization

import 'data_repository/agent_repository_test.dart' as agent_tests;
import 'data_repository/commune_repository_test.dart' as commune_tests;
import 'data_repository/categorie_repository_test.dart' as categorie_tests;
import 'data_repository/infraction_repository_test.dart' as infraction_tests;
import 'data_repository/violant_repository_test.dart' as violant_tests;
import 'data_repository/decision_repository_test.dart' as decision_tests;
import 'data_repository/error_handling_test.dart' as error_tests;

void main() {
  // Run all data repository tests
  agent_tests.main();
  commune_tests.main();
  categorie_tests.main();
  infraction_tests.main();
  violant_tests.main();
  decision_tests.main();
  error_tests.main();
}
