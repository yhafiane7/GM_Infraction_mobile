import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/features/categorie/controllers/categorie_controller.dart';
import 'package:GM_INFRACTION/features/categorie/widgets/snackbar_service.dart';

/// Dialog for editing category
class CategorieEditDialog extends StatefulWidget {
  final Categorie categorie;
  final CategorieController? controller;
  final int categoryIndex;
  final Function(int, Categorie)? onCategoryUpdated;

  const CategorieEditDialog({
    super.key,
    required this.categorie,
    this.controller,
    required this.categoryIndex,
    this.onCategoryUpdated,
  });

  @override
  State<CategorieEditDialog> createState() => _CategorieEditDialogState();
}

class _CategorieEditDialogState extends State<CategorieEditDialog> {
  late TextEditingController _nomController;
  late TextEditingController _degreController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.categorie.nom);
    _degreController =
        TextEditingController(text: widget.categorie.degre.toString());
  }

  @override
  void dispose() {
    _nomController.dispose();
    _degreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Dialog.fullscreen(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEditForm(),
              const SizedBox(height: 20),
              _buildEditButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditForm() {
    return Column(
      children: [
        TextFormField(
          controller: _nomController,
          decoration: const InputDecoration(
            labelText: 'Nom',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _degreController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Degré',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildEditButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          icon: const Icon(Icons.cancel),
          label: const Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.orange[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text('Enregistrer'),
          onPressed: () => _performUpdate(context),
        ),
      ],
    );
  }

  void _performUpdate(BuildContext context) {
    if (widget.controller != null && widget.categorie.id != null) {
      final updatedCategorie = Categorie(
        id: widget.categorie.id,
        nom: _nomController.text,
        degre: int.tryParse(_degreController.text) ?? widget.categorie.degre,
      );

      widget.controller!
          .updateCategorie(widget.categoryIndex, updatedCategorie)
          .then((result) {
        Navigator.of(context).pop(); // Close edit dialog
        SnackbarService.showMessage(result, isError: result.contains('Error'));

        // ✅ Only update locally if server update was successful
        if (!result.contains('Error') && widget.onCategoryUpdated != null) {
          widget.onCategoryUpdated!(widget.categoryIndex, updatedCategorie);
        }
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
        // ❌ Don't update locally if there's an error
      });
    } else {
      SnackbarService.showMessage('Controller not available', isError: true);
    }
  }
}
