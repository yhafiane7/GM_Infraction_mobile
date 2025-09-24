import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';
import 'package:gmsoft_infractions_mobile/models/commune_model.dart';
import 'package:gmsoft_infractions_mobile/models/violant_model.dart';
import 'package:gmsoft_infractions_mobile/features/infraction/controllers/infraction_controller.dart';
import 'package:gmsoft_infractions_mobile/features/infraction/widgets/infraction_form_widget.dart';

class InfractionViewWidget extends StatelessWidget {
  static const String route = "/infraction/create";
  static const String _title = 'Ajouter une Infraction';

  final List<Commune> communes;
  final List<Violant> violants;
  final List<Agent> agents;
  final List<Categorie> categories;

  const InfractionViewWidget({
    super.key,
    required this.communes,
    required this.violants,
    required this.agents,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final controller = InfractionController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: InfractionFormWidget(
        communes: communes,
        violants: violants,
        agents: agents,
        categories: categories,
        controller: controller,
      ),
    );
  }
}
