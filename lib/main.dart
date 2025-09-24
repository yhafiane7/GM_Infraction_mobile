import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/config/app_theme.dart';
import 'package:gmsoft_infractions_mobile/routing.dart';
import 'package:gmsoft_infractions_mobile/services/snackbar_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRouting.main(context),
      builder: (context, child) {
        return ScaffoldMessenger(
          key: SnackbarService.scaffoldMessengerKey,
          child: child!,
        );
      },
    );
  }
}
