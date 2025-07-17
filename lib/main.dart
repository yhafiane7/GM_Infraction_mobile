import 'package:flutter/material.dart';
import 'package:gmsoft_pkg/config/global_params.dart'; 
import 'package:GM_INFRACTION/routing.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final config = context.read(flavorConfigProvider);
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: GlobalParams.GlobalColor,
        ),
        fontFamily: GlobalParams.MainfontFamily,
      ),
      // title: config.state.appTitle,
      // theme: config.state.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRouting.main(context),
    );
  }
}
