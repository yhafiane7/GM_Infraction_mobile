import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';
import 'package:gmsoft_infractions_mobile/features/categorie/controllers/categorie_controller.dart';
import 'package:gmsoft_infractions_mobile/services/snackbar_service.dart';
import 'package:gmsoft_infractions_mobile/features/categorie/widgets/categorie_edit_dialog.dart';

/// Dialog for showing category details and actions
class CategorieDetailsDialog extends StatelessWidget {
  final Categorie categorie;
  final CategorieController? controller;
  final int categoryIndex;
  final Function(int, Categorie)? onCategoryUpdated;

  const CategorieDetailsDialog({
    super.key,
    required this.categorie,
    this.controller,
    required this.categoryIndex,
    this.onCategoryUpdated,
  });

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
              // Category details display
              _buildCategoryDetails(),
              const SizedBox(height: 20),
              // Action buttons
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDetails() {
    return Column(
      children: [
        Text(
          'Nom: ${categorie.nom}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Degré: ${categorie.degre}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Delete button
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          icon: const Icon(Icons.delete_forever_outlined),
          label: const Text('Supprimer'),
          onPressed: () => _showDeleteConfirmation(context),
        ),
        // Edit button
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Modifier'),
          onPressed: () => _showEditDialog(context),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    // Store the original context before opening the confirmation dialog
    final originalContext = context;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Catégorie à supprimer:'),
              const SizedBox(height: 8),
              Text('Nom: ${categorie.nom}'),
              Text('Degré: ${categorie.degre}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close confirmation dialog
                _confirmDelete(originalContext);
              },
              child: const Text('Confirmer'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close confirmation dialog
              },
              child: const Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context) {
    Navigator.of(context).pop(); // Close details dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategorieEditDialog(
          categorie: categorie,
          controller: controller,
          categoryIndex: categoryIndex,
          onCategoryUpdated: onCategoryUpdated,
        );
      },
    );
  }

  void _confirmDelete(BuildContext context) {
    Navigator.of(context).pop(); // Close confirmation dialog first

    if (controller != null && categorie.id != null) {
      controller!.deleteCategorie(categorie.id!, categorie).then((result) {
        SnackbarService.showMessage(result, isError: result.contains('Error'));
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage(
          "Controller not available or Category ID is null",
          isError: true);
    }
  }
}
