# Test Structure Documentation

This document describes the organized test structure for the Infraction Commune Mobile project.

## Directory Structure

```
test/
├── config/                 # Configuration tests
│   └── app_config_test.dart
├── integration/            # Integration tests
│   ├── api_connection_test.dart
│   └── user_flow_test.dart
├── models/                 # Model unit tests
│   ├── agent_model_test.dart
│   ├── button_option_test.dart
│   ├── categorie_model_test.dart
│   ├── commune_model_test.dart
│   ├── decision_model_test.dart
│   ├── infraction_model_test.dart
│   └── violant_model_test.dart
├── services/               # Service layer tests
│   ├── api_client/
│   │   ├── get_data_test.dart
│   │   ├── post_data_test.dart
│   │   ├── delete_data_test.dart
│   │   └── update_data_test.dart
│   ├── data_repository/
│   │   ├── agent_repository_test.dart
│   │   ├── categorie_repository_test.dart
│   │   ├── commune_repository_test.dart
│   │   ├── decision_repository_test.dart
│   │   ├── error_handling_test.dart
│   │   └── violant_repository_test.dart
│   ├── data_repository_test.dart
│   └── ui_service/
│       ├── ui_service_agent_test.dart
│       ├── ui_service_commune_test.dart
│       ├── ui_service_categorie_test.dart
│       ├── ui_service_infraction_test.dart
│       ├── ui_service_violant_test.dart
│       ├── ui_service_decision_test.dart
│       └── ui_service_decorations_test.dart
├── test_helpers/           # Test utilities and helpers
│   ├── mock_responses.dart
│   ├── test_factory.dart
│   └── toast_mock.dart
├── unit/                   # Additional unit tests
│   └── page_base_test.dart
├── widgets/                # Widget tests for UI components
│   ├── agent_entity_test.dart
│   ├── app_routing_test.dart
│   ├── categorie_entity_test.dart
│   ├── commune_entity_test.dart
│   ├── dashboard_test.dart
│   ├── decision_entity_test.dart
│   ├── infraction_entity_test.dart
│   ├── navigation_button_test.dart
│   └── violant_entity_test.dart
├── routing_test.dart       # Routing logic tests
├── test_runner.dart        # Test execution documentation
├── widget_test.dart        # Basic app widget test
└── README.md              # This file
```

## Test Organization Principles

### 1. **Separation of Concerns**

- **Unit Tests**: Test individual functions, methods, and classes in isolation
- **Widget Tests**: Test UI components and user interactions
- **Integration Tests**: Test how different parts work together

### 2. **Focused Test Files**

- Each test file focuses on a single component or feature
- Tests are grouped by functionality, not by test type
- Maximum file size should be around 200-300 lines

### 3. **Consistent Test Patterns**

- All tests follow the Arrange-Act-Assert pattern
- Consistent naming conventions for test methods
- Standardized setup and teardown procedures

## Running Tests

### Run All Tests

```bash
flutter test
```

### Run Specific Test Suites

```bash
# Unit tests only
flutter test test/unit/

# Widget tests only
flutter test test/widget/

# Integration tests only
flutter test test/integration/

# Specific test file
flutter test test/unit/models/agent_model_test.dart
```

### Run Tests with Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Test Utilities

### TestFactory

Centralized factory for creating test data:

```dart
// Create test objects
final agent = TestFactory.createAgent();
final agents = TestFactory.createAgentList(5);

// Use builder pattern
final customAgent = TestFactory.agentBuilder()
    .withName('Custom')
    .withPrenom('Agent')
    .build();
```

### TestBase Classes

Base classes for common test setup:

- `TestBase`: General test utilities
- `WidgetTestBase`: Widget test helpers
- `ServiceTestBase`: Service test setup with mocks

### TestAssertions

Utility methods for common assertions:

```dart
TestAssertions.expectListLength(list, 5);
TestAssertions.expectNotEmpty(string);
TestAssertions.expectNotNull(value);
```

## Best Practices

### 1. **Test Naming**

- Use descriptive test names that explain what is being tested
- Follow the pattern: `should [expected behavior] when [condition]`

### 2. **Test Data**

- Use the TestFactory for consistent test data
- Avoid hardcoded values in tests
- Create specific test data for edge cases

### 3. **Mocking**

- Mock external dependencies (APIs, databases, etc.)
- Use consistent mock setup and teardown
- Mock at the appropriate level (not too deep, not too shallow)

### 4. **Assertions**

- Use specific assertions rather than generic ones
- Test both positive and negative cases
- Verify side effects when appropriate

### 5. **Test Maintenance**

- Keep tests simple and focused
- Refactor tests when refactoring production code
- Remove obsolete tests promptly

## Migration from Old Structure

The old test structure had several issues:

- Large, monolithic test files (900+ lines)
- Mixed test types in single files
- Duplicated test data and setup
- Inconsistent test patterns

The new structure addresses these issues by:

- Splitting large files into focused, single-responsibility tests
- Organizing tests by type and feature
- Centralizing test utilities and data
- Standardizing test patterns and naming

## Future Improvements

1. **Test Coverage**: Add more comprehensive test coverage
2. **Performance Tests**: Add performance benchmarks
3. **E2E Tests**: Add end-to-end test automation
4. **Visual Tests**: Add golden file tests for UI consistency
5. **Test Data Management**: Enhance test data factories with more scenarios
