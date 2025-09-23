import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/features/decision/controllers/decision_controller.dart';
import 'package:GM_INFRACTION/features/decision/widgets/decision_form_widget.dart';

class DecisionViewWidget extends StatelessWidget {
  static const String route = "/decision/create";
  static const String _title = 'Ajouter une Décision';

  const DecisionViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DecisionController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: DecisionFormWidget(controller: controller),
    );
  }
}


