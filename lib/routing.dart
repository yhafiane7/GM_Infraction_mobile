import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:GM_INFRACTION/decision.dart';
import 'package:GM_INFRACTION/home.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/page_base.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';

// import 'agent.dart';
import 'features/agent/agent.dart' as agent;
// Removed old categorie.dart implementation
import 'features/commune/commune.dart' as commune;
// import 'infraction.dart';
// import 'violant.dart';
import 'features/categorie/categorie.dart' as categorie;
import 'features/violant/violant.dart' as violant;
import 'features/infraction/infraction.dart' as infraction;
import 'features/decision/decision.dart' as decision;

class AppRouting {
  static Map<String, Widget Function(BuildContext)> main(BuildContext context) {
    return {
      '/': (context) => const Home(),
      agent.AgentListWidget.route: (context) => const BasePage(title: 'Agent'),
      violant.ViolantListWidget.route: (context) =>
          const BasePage(title: 'Violant'),
      categorie.CategorieListWidget.route: (context) =>
          const BasePage(title: 'Categorie'),
      commune.CommuneListWidget.route: (context) =>
          const BasePage(title: 'Commune'),
      decision.DecisionListWidget.route: (context) =>
          const BasePage(title: 'Decision'),
      infraction.InfractionListWidget.route: (context) =>
          const BasePage(title: 'Infraction'),
      agent.AgentViewWidget.route: (context) => const agent.AgentViewWidget(),
      commune.CommuneViewWidget.route: (context) =>
          const commune.CommuneViewWidget(),
      violant.ViolantViewWidget.route: (context) =>
          const violant.ViolantViewWidget(),
      categorie.CategorieViewWidget.route: (context) =>
          const categorie.CategorieViewWidget(),
      decision.DecisionViewWidget.route: (context) =>
          const decision.DecisionViewWidget(),
      infraction.InfractionViewWidget.route: (context) =>
          FutureBuilder<List<dynamic>>(
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
                return infraction.InfractionViewWidget(
                    communes: communes,
                    violants: violants,
                    agents: agents,
                    categories: categories);
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
