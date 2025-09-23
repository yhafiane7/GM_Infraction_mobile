import 'package:flutter/material.dart';
// import 'package:GM_INFRACTION/agent.dart';
import 'package:GM_INFRACTION/features/agent/agent.dart' as agent_v2;
import 'package:GM_INFRACTION/features/categorie/categorie.dart'
    as categorie_v2;
import 'package:GM_INFRACTION/features/commune/commune.dart' as commune_v2;
// import 'package:GM_INFRACTION/decision.dart';
import 'package:GM_INFRACTION/features/decision/decision.dart' as decision_v2;
// import 'package:GM_INFRACTION/infraction.dart';
import 'package:GM_INFRACTION/features/infraction/infraction.dart'
    as infraction_v2;
// import 'package:GM_INFRACTION/violant.dart';
import 'package:GM_INFRACTION/features/violant/violant.dart' as violant_v2;
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
              return agent_v2.AgentListWidget(
                  agents: snapshot.data! as List<Agent>,
                  controller: agent_v2.AgentController());
            case 'Violant':
              return violant_v2.ViolantListWidget(
                  violants: snapshot.data! as List<Violant>,
                  controller: violant_v2.ViolantController());
            case 'Categorie':
              return categorie_v2.CategorieListWidget(
                  categories: snapshot.data! as List<Categorie>,
                  controller: categorie_v2.CategorieController());
            case 'Commune':
              return commune_v2.CommuneListWidget(
                  communes: snapshot.data! as List<Commune>,
                  controller: commune_v2.CommuneController());
            case 'Decision':
              return decision_v2.DecisionListWidget(
                  decisions: snapshot.data! as List<Decision>,
                  controller: decision_v2.DecisionController());
            case 'Infraction':
              return infraction_v2.InfractionListWidget(
                  infractions: snapshot.data! as List<Infraction>,
                  controller: infraction_v2.InfractionController());
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
    case 'categorie v2':
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
