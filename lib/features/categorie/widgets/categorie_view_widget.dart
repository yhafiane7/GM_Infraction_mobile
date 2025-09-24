import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/features/categorie/widgets/categorie_form_widget.dart';
import 'package:gmsoft_infractions_mobile/features/categorie/controllers/categorie_controller.dart';

/// Main view for creating a new category
class CategorieViewWidget extends StatelessWidget {
  static const String route = "/categorie/create";
  static const String _title = 'Ajouter une Catégorie';

  const CategorieViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Create controller here
    final controller = CategorieController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: CategorieFormWidget(controller: controller),
    );
  }
}
