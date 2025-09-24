import 'package:flutter/material.dart';

class ButtonOption {
  final String? route;
  final String text;
  final IconData? iconData;
  final String? subText;
  final bool isVisible;
  final dynamic arguments;

  const ButtonOption({
    this.route,
    required this.text,
    this.iconData,
    this.subText,
    this.isVisible = true,
    this.arguments,
  });
}
