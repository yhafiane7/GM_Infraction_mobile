import 'package:flutter/material.dart';
// import 'package:GM_INFRACTION/agent.dart';
import 'package:GM_INFRACTION/features/agent/agent.dart' as agent;
import 'package:GM_INFRACTION/features/categorie/categorie.dart' as categorie;
import 'package:GM_INFRACTION/features/commune/commune.dart' as commune;
// import 'package:GM_INFRACTION/decision.dart';
import 'package:GM_INFRACTION/features/decision/decision.dart' as decision;
// import 'package:GM_INFRACTION/infraction.dart';
import 'package:GM_INFRACTION/features/infraction/infraction.dart'
    as infraction;
// import 'package:GM_INFRACTION/violant.dart';
import 'package:GM_INFRACTION/features/violant/violant.dart' as violant;
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';

import 'models/agent_model.dart';

class BasePage extends StatefulWidget {
  final String title;

  const BasePage({Key? key, required this.title}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<BasePage> {
  List<dynamic> data = [];

  Future<void> refreshData() async {
    // Fetch the data again and update the state
    List<dynamic> newData = await buildList(widget.title);
    setState(() {
      data = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)!.settings.name;

    String getCreateRoute(String? route) {
      if (route != null && !route.endsWith('/create')) {
        return '$route/create';
      }
      return route ?? '';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                final createRoute = getCreateRoute(currentRoute);
                Navigator.pushNamed(context, createRoute);
              },
              icon: const Icon(Icons.add_circle),
            )
          ],
        ),
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: refreshData,
          child: buildtheList(widget.title),
        ));
  }
}

FutureBuilder<List<dynamic>> buildtheList(String title) {
  return FutureBuilder<List<dynamic>>(
      future: buildList(title), // call BuildList method
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot);
          return const Center(
            child: Text('Erreur'),
          );
        } else if (snapshot.hasData) {
          switch (title) {
            case 'Agent':
              return agent.AgentListWidget(
                  agents: snapshot.data! as List<Agent>,
                  controller: agent.AgentController());
            case 'Violant':
              return violant.ViolantListWidget(
                  violants: snapshot.data! as List<Violant>,
                  controller: violant.ViolantController());
            case 'Categorie':
              return categorie.CategorieListWidget(
                  categories: snapshot.data! as List<Categorie>,
                  controller: categorie.CategorieController());
            case 'Commune':
              return commune.CommuneListWidget(
                  communes: snapshot.data! as List<Commune>,
                  controller: commune.CommuneController());
            case 'Decision':
              return decision.DecisionListWidget(
                  decisions: snapshot.data! as List<Decision>,
                  controller: decision.DecisionController());
            case 'Infraction':
              return infraction.InfractionListWidget(
                  infractions: snapshot.data! as List<Infraction>,
                  controller: infraction.InfractionController());
            default:
              return const Center(
                child: Text('Unkown title'),
              );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

Future<List<dynamic>> buildList(String title) async {
  title = title.toLowerCase();
  switch (title) {
    case 'agent':
      return await UiService.buildAgentList();
    case 'violant':
      return await UiService.buildViolantList();
    case 'categorie':
      return await UiService.buildCategorieList();
    case 'commune':
      return await UiService.buildCommuneList();
    case 'decision':
      return await UiService.buildDecisionList();
    case 'infraction':
      return await UiService.buildInfractionList();
    default:
      throw Exception('Invalid TITLE : $title');
  }
}
