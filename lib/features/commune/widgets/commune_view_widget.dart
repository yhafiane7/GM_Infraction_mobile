import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/features/commune/widgets/commune_form_widget.dart';
import 'package:GM_INFRACTION/features/commune/controllers/commune_controller.dart';

class CommuneViewWidget extends StatelessWidget {
  static const String route = "/commune/create";
  static const String _title = 'Ajouter une Commune';
  const CommuneViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CommuneController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: CommuneFormWidget(controller: controller),
    );
  }
}
