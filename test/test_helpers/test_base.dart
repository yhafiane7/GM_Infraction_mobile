import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Base class for all tests with common setup and utilities
abstract class TestBase {
  /// Setup method called before each test
  void setUp() {}

  /// Teardown method called after each test
  void tearDown() {}

  /// Setup method called once before all tests in a group
  void setUpAll() {}

  /// Teardown method called once after all tests in a group
  void tearDownAll() {}
}

/// Base class for widget tests with common widget setup
abstract class WidgetTestBase extends TestBase {
  /// Creates a MaterialApp wrapper for widget tests
  Widget createTestApp(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  /// Creates a MaterialApp with routing for widget tests
  Widget createTestAppWithRoutes(
      Widget child, Map<String, Widget Function(BuildContext)> routes) {
    return MaterialApp(
      home: Scaffold(body: child),
      routes: routes,
    );
  }
}

/// Base class for service tests with mock setup
abstract class ServiceTestBase extends TestBase {
  /// Setup method for mocking FlutterToast plugin
  void setupFlutterToastMocks() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('PonnamKarthik/fluttertoast'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'showToast') {
          return null;
        }
        return null;
      },
    );
  }

  /// Teardown method for cleaning up mocks
  void teardownFlutterToastMocks() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('PonnamKarthik/fluttertoast'),
      null,
    );
  }
}

/// Utility class for common test assertions
class TestAssertions {
  /// Asserts that a list contains the expected number of items
  static void expectListLength<T>(List<T> list, int expectedLength) {
    expect(list.length, equals(expectedLength));
  }

  /// Asserts that a string is not empty
  static void expectNotEmpty(String value) {
    expect(value, isNotEmpty);
  }

  /// Asserts that a value is not null
  static void expectNotNull<T>(T? value) {
    expect(value, isNotNull);
  }

  /// Asserts that a value is null
  static void expectNull<T>(T? value) {
    expect(value, isNull);
  }
}

/// Utility class for test data generation
class TestDataGenerator {
  /// Generates a unique timestamp string
  static String uniqueTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Generates a unique ID string
  static String uniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(8);
  }

  /// Generates a test phone number
  static String testPhoneNumber() {
    return uniqueId().padLeft(10, '0');
  }

  /// Generates a test CIN
  static String testCin(String prefix) {
    return '$prefix${uniqueId()}';
  }
}
