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
import 'features/agent/agent.dart' as agent_v2;
// Removed old categorie.dart implementation
import 'features/commune/commune.dart' as commune_v2;
// import 'infraction.dart';
// import 'violant.dart';
import 'features/categorie/categorie.dart' as categorie_v2;
import 'features/violant/violant.dart' as violant_v2;
import 'features/infraction/infraction.dart' as infraction_v2;
import 'features/decision/decision.dart' as decision_v2;

class AppRouting {
  static Map<String, Widget Function(BuildContext)> main(BuildContext context) {
    return {
      '/': (context) => const Home(),
      agent_v2.AgentListWidget.route: (context) =>
          const BasePage(title: 'Agent'),
      violant_v2.ViolantListWidget.route: (context) =>
          const BasePage(title: 'Violant'),
      categorie_v2.CategorieListWidget.route: (context) =>
          const BasePage(title: 'Categorie'),
      commune_v2.CommuneListWidget.route: (context) =>
          const BasePage(title: 'Commune'),
      decision_v2.DecisionListWidget.route: (context) =>
          const BasePage(title: 'Decision'),
      infraction_v2.InfractionListWidget.route: (context) =>
          const BasePage(title: 'Infraction'),
      agent_v2.AgentViewWidget.route: (context) =>
          const agent_v2.AgentViewWidget(),
      commune_v2.CommuneViewWidget.route: (context) =>
          const commune_v2.CommuneViewWidget(),
      violant_v2.ViolantViewWidget.route: (context) =>
          const violant_v2.ViolantViewWidget(),
      categorie_v2.CategorieViewWidget.route: (context) =>
          const categorie_v2.CategorieViewWidget(),
      decision_v2.DecisionViewWidget.route: (context) =>
          const decision_v2.DecisionViewWidget(),
      infraction_v2.InfractionViewWidget.route: (context) =>
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
                return infraction_v2.InfractionViewWidget(
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
