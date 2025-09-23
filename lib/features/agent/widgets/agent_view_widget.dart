import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/features/agent/controllers/agent_controller.dart';
import 'package:GM_INFRACTION/features/agent/widgets/agent_form_widget.dart';

class AgentViewWidget extends StatelessWidget {
  static const String route = "/agent/create";
  static const String _title = 'Ajouter un Agent';

  const AgentViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AgentController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: AgentFormWidget(controller: controller),
    );
  }
}
