import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gmsoft_infractions_mobile/services/ui_service.dart';

void main() {
  group('UiService Decorations', () {
    test('buildInputDecoration builds expected properties', () {
      final deco =
          UiService.buildInputDecoration('Hint', Icons.home, Colors.blue);
      expect(deco.hintText, 'Hint');
      expect(deco.prefixIcon, isA<Icon>());
      expect(deco.border, isA<OutlineInputBorder>());
      expect(deco.enabledBorder, isA<OutlineInputBorder>());
      expect(deco.focusedBorder, isA<OutlineInputBorder>());
      expect(deco.errorBorder, isA<OutlineInputBorder>());
      expect(deco.focusedErrorBorder, isA<OutlineInputBorder>());
    });

    test('buildShowDecoration builds expected properties', () {
      final deco =
          UiService.buildShowDecoration('Value', Icons.person, Colors.green);
      expect(deco.labelText, 'Value');
      expect(deco.prefixIcon, isA<Icon>());
      expect(deco.border, isA<OutlineInputBorder>());
      expect(deco.enabledBorder, isA<OutlineInputBorder>());
      expect(deco.focusedBorder, isA<OutlineInputBorder>());
    });
  });
}
