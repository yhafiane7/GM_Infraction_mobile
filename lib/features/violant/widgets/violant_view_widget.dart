import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/features/violant/controllers/violant_controller.dart';
import 'package:gmsoft_infractions_mobile/features/violant/widgets/violant_form_widget.dart';

class ViolantViewWidget extends StatelessWidget {
  static const String route = "/violant/create";
  static const String _title = 'Ajouter un Violant';

  const ViolantViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ViolantController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ViolantFormWidget(controller: controller),
    );
  }
}
