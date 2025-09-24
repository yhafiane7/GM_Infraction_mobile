import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Provides setup/teardown for mocking the Fluttertoast MethodChannel.
class ToastMock {
  static const MethodChannel _channel =
      MethodChannel('PonnamKarthik/fluttertoast');

  /// Call in setUpAll to silence toast calls in tests.
  static Future<void> setUp() async {
    // Ensure test binding is initialized before accessing the messenger
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      _channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'showToast') {
          return null;
        }
        return null;
      },
    );
  }

  /// Call in tearDownAll to remove the mock handler.
  static Future<void> tearDown() async {
    // Ensure binding is initialized in case this is the first call encountered
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      _channel,
      null,
    );
  }
}
