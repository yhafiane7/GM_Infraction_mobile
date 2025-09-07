import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/models/button_option.dart';

void main() {
  group('ButtonOption Model Tests', () {
    test('should create ButtonOption with all properties', () {
      const buttonOption = ButtonOption(
        route: '/test',
        text: 'Test Button',
        subText: 'Sub text',
        iconData: Icons.home,
        isVisible: true,
        arguments: {'key': 'value'},
      );

      expect(buttonOption.route, equals('/test'));
      expect(buttonOption.text, equals('Test Button'));
      expect(buttonOption.subText, equals('Sub text'));
      expect(buttonOption.iconData, equals(Icons.home));
      expect(buttonOption.isVisible, equals(true));
      expect(buttonOption.arguments, equals({'key': 'value'}));
    });

    test('should create ButtonOption with minimal properties', () {
      const buttonOption = ButtonOption(
        text: 'Test Button',
      );

      expect(buttonOption.route, isNull);
      expect(buttonOption.text, equals('Test Button'));
      expect(buttonOption.subText, isNull);
      expect(buttonOption.iconData, isNull);
      expect(buttonOption.isVisible, equals(true)); // Default value
      expect(buttonOption.arguments, isNull);
    });

    test('should create ButtonOption with null route', () {
      const buttonOption = ButtonOption(
        route: null,
        text: 'Test Button',
        iconData: Icons.home,
      );

      expect(buttonOption.route, isNull);
      expect(buttonOption.text, equals('Test Button'));
      expect(buttonOption.iconData, equals(Icons.home));
    });

    test('should create ButtonOption with false visibility', () {
      const buttonOption = ButtonOption(
        text: 'Test Button',
        isVisible: false,
      );

      expect(buttonOption.isVisible, equals(false));
    });

    test('should create ButtonOption with empty arguments', () {
      const buttonOption = ButtonOption(
        text: 'Test Button',
        arguments: {},
      );

      expect(buttonOption.arguments, equals({}));
    });

    test('should create ButtonOption with complex arguments', () {
      const buttonOption = ButtonOption(
        text: 'Test Button',
        arguments: {
          'id': 123,
          'name': 'test',
          'enabled': true,
        },
      );

      expect(
          buttonOption.arguments,
          equals({
            'id': 123,
            'name': 'test',
            'enabled': true,
          }));
    });

    test('should handle different icon types', () {
      const buttonOption1 = ButtonOption(
        text: 'Home',
        iconData: Icons.home,
      );

      const buttonOption2 = ButtonOption(
        text: 'Person',
        iconData: Icons.person,
      );

      const buttonOption3 = ButtonOption(
        text: 'Settings',
        iconData: Icons.settings,
      );

      expect(buttonOption1.iconData, equals(Icons.home));
      expect(buttonOption2.iconData, equals(Icons.person));
      expect(buttonOption3.iconData, equals(Icons.settings));
    });

    test('should handle long text', () {
      const longText =
          'This is a very long button text that might cause overflow issues';
      const buttonOption = ButtonOption(
        text: longText,
      );

      expect(buttonOption.text, equals(longText));
    });

    test('should handle special characters in text', () {
      const specialText = 'Test & Button (Special) [Characters]';
      const buttonOption = ButtonOption(
        text: specialText,
      );

      expect(buttonOption.text, equals(specialText));
    });

    test('should be immutable', () {
      const buttonOption = ButtonOption(
        route: '/test',
        text: 'Test Button',
        iconData: Icons.home,
      );

      // All properties should be final and const
      expect(buttonOption.route, equals('/test'));
      expect(buttonOption.text, equals('Test Button'));
      expect(buttonOption.iconData, equals(Icons.home));
    });
  });
}
