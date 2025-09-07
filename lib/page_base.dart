import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/Agent.dart';
import 'package:GM_INFRACTION/Categorie.dart';
import 'package:GM_INFRACTION/Commune.dart';
import 'package:GM_INFRACTION/Decision.dart';
import 'package:GM_INFRACTION/Infraction.dart';
import 'package:GM_INFRACTION/Violant.dart';
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
              return AgentList(Agents: snapshot.data! as List<Agent>);
            case 'Violant':
              return ViolantList(Violants: snapshot.data! as List<Violant>);
            case 'Categorie':
              return CategorieList(
                  Categories: snapshot.data! as List<Categorie>);
            case 'Commune':
              return CommuneList(Communes: snapshot.data! as List<Commune>);
            case 'Decision':
              return DecisionList(Decisions: snapshot.data! as List<Decision>);
            case 'Infraction':
              return InfractionList(
                  Infractions: snapshot.data! as List<Infraction>);
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
