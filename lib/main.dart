import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/config/app_theme.dart';
import 'package:GM_INFRACTION/routing.dart';
import 'package:GM_INFRACTION/web_wrapper.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(kIsWeb ? const WebWrapper() : MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final config = context.read(flavorConfigProvider);
    return MaterialApp(
      theme: AppTheme.lightTheme,
      // title: config.state.appTitle,
      // theme: config.state.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRouting.main(context),
    );
  }
}
