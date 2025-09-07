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
    final screenSize = MediaQuery.of(context).size;

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
      // Container(
      //     child: Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      //       SizedBox(
      //           width: screenSize.width * 0.4,
      //           height: screenSize.height * 0.1,
      //           child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                   textStyle: const TextStyle(fontSize: 28)),
      //               onPressed: () { Navigator.pushNamed(context, '/infraction');},
      //               child: const Text('Infraction'))),
      //       SizedBox(
      //           width: screenSize.width * 0.4,
      //           height: screenSize.height * 0.1,
      //           child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                   textStyle: const TextStyle(fontSize: 28)),
      //               onPressed: () {
      //                 Navigator.pushNamed(context, '/agent');
      //               },
      //               child: const Text('Agent')))
      //     ]),
      //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      //       SizedBox(
      //           width: screenSize.width * 0.4,
      //           height: screenSize.height * 0.1,
      //           child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                   textStyle: TextStyle(fontSize: 28)),
      //               onPressed: () { Navigator.pushNamed(context, '/categorie');},
      //               child: const Text('Catégorie'))),
      //       SizedBox(
      //           width: screenSize.width * 0.4,
      //           height: screenSize.height * 0.1,
      //           child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                   textStyle: const TextStyle(fontSize: 28)),
      //               onPressed: () {
      //                 Navigator.pushNamed(context, '/violant');
      //               },
      //               child: const Text('Violent')))
      //     ]),
      //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      //       SizedBox(
      //           width: screenSize.width * 0.4,
      //           height: screenSize.height * 0.1,
      //           child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                   textStyle: const TextStyle(fontSize: 28)),
      //               onPressed: () {Navigator.pushNamed(context, '/commune');},
      //               child: Text('Commune'))),
      //       SizedBox(
      //           width: screenSize.width * 0.4,
      //           height: screenSize.height * 0.1,
      //           child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                   textStyle: const TextStyle(fontSize: 28)),
      //               onPressed: () {Navigator.pushNamed(context, '/decision');},
      //               child: const Text('Décision')))
      //     ])
      //   ],
      // )),
    );
  }
}
