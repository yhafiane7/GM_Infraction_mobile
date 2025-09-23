import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/button_option.dart';
import 'package:GM_INFRACTION/widgets/dashboard_view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static List<ButtonOption> Options = const <ButtonOption>[
    ButtonOption(route: "/agent", text: 'AGENT', iconData: Icons.person),
    ButtonOption(
      route: "/categorie",
      text: 'CATEGORIE',
      iconData: Icons.category,
    ),
    //violant
    ButtonOption(
        route: "/violant",
        text: 'VIOLANT',
        isVisible: true,
        iconData: Icons.home),
    ButtonOption(
        route: "/commune",
        text: 'COMMUNE',
        isVisible: true,
        iconData: Icons.home),
    ButtonOption(route: "/decision", text: 'DECISION', iconData: Icons.pages),
    ButtonOption(
        route: "/infraction", text: 'INFRACTION', iconData: Icons.info_sharp),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion Des Infractions'),
        // centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: DashboardView(options: Home.Options),
    );
  }
}
