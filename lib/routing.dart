import 'package:flutter/material.dart';
import 'dart:async';
import 'package:GM_INFRACTION/decision.dart';
import 'package:GM_INFRACTION/home.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/page_base.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';

import 'agent.dart';
// Removed old categorie.dart implementation
import 'commune.dart';
import 'infraction.dart';
import 'violant.dart';
import 'features/categorie/categorie.dart' as categorie_v2;

class AppRouting {
  static Map<String, Widget Function(BuildContext)> main(BuildContext context) {
    return {
      '/': (context) => const Home(),
      AgentList.Route: (context) => const BasePage(title: 'Agent'),
      ViolantList.Route: (context) => const BasePage(title: 'Violant'),
      categorie_v2.CategorieListWidget.route: (context) =>
          const BasePage(title: 'Categorie'),
      CommuneList.Route: (context) => const BasePage(title: 'Commune'),
      DecisionList.Route: (context) => const BasePage(title: 'Decision'),
      InfractionList.Route: (context) => const BasePage(title: 'Infraction'),
      AgentView.Route: (context) => const AgentView(),
      CommuneView.Route: (context) => const CommuneView(),
      ViolantView.Route: (context) => const ViolantView(),
      categorie_v2.CategorieViewWidget.route: (context) =>
          const categorie_v2.CategorieViewWidget(),
      DecisionView.Route: (context) => const DecisionView(),
      InfractionView.Route: (context) => FutureBuilder<List<dynamic>>(
            future: Future.wait([
              UiService.buildCommuneList(),
              UiService.buildViolantList(),
              UiService.buildAgentList(),
              UiService.buildCategorieList()
            ]), // Call both functions using Future.wait
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Erreur'),
                );
              } else if (snapshot.hasData) {
                final List<Commune> communes = snapshot.data![0]
                    as List<Commune>; // Extract communes from snapshot data
                final List<Violant> violants = snapshot.data![1]
                    as List<Violant>; // Extract violants from snapshot data
                final List<Agent> agents = snapshot.data![2]
                    as List<Agent>; // Extract agents from snapshot data
                final List<Categorie> categories = snapshot.data![3]
                    as List<Categorie>; // Extract categories from snapshot data
                return InfractionView(
                    Communes: communes,
                    Violants: violants,
                    Agents: agents,
                    Categories: categories);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
    };
  }
}

typedef Builder<T> = T Function(BuildContext context);

String routeName<T extends Widget>() {
  return T.toString().toLowerCase();
}

MapEntry<String, Builder<Widget>> createRouteWithName<T extends Widget>(
    Builder<T> builder) {
  return MapEntry(routeName<T>(), (context) => builder(context));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: routeName<ScreenPicker>(),
      routes: Map.fromEntries([
        // createRouteWithName((context) => ScreenPicker()),
        // createRouteWithName((context) => ScreenOne()),
        // createRouteWithName((context) => ScreenTwo()),
      ]),
    );
  }
}
