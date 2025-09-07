import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/config/app_theme.dart';
import 'package:GM_INFRACTION/routing.dart';

void main() => runApp(MyApp());

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
