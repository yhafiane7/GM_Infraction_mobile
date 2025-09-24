import 'package:flutter/material.dart';

class SnackbarService {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  static void showMessage(
    String message, {
    bool isError = false,
    int durationSeconds = 3,
  }) {
    final scaffoldMessenger = _scaffoldMessengerKey.currentState;
    if (scaffoldMessenger != null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError ? Colors.red[400] : Colors.green[400],
          duration: Duration(seconds: durationSeconds),
        ),
      );
    } else {
      debugPrint('SnackbarService: No scaffoldMessenger available');
    }
  }
}
