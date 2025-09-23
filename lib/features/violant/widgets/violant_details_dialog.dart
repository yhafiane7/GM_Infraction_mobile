import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/features/violant/controllers/violant_controller.dart';
import 'package:GM_INFRACTION/services/snackbar_service.dart';
import 'package:GM_INFRACTION/features/violant/widgets/violant_edit_dialog.dart';

class ViolantDetailsDialog extends StatelessWidget {
  final Violant violant;
  final ViolantController? controller;
  final int violantIndex;
  final Function(int, Violant)? onViolantUpdated;

  const ViolantDetailsDialog({
    super.key,
    required this.violant,
    this.controller,
    required this.violantIndex,
    this.onViolantUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Dialog.fullscreen(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetails(),
              const SizedBox(height: 20),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      children: [
        Text('Nom: ${violant.nom}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Prénom: ${violant.prenom}'),
        Text('CIN: ${violant.cin}'),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          icon: const Icon(Icons.delete_forever_outlined),
          label: const Text('Supprimer'),
          onPressed: () => _showDeleteConfirmation(context),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[300],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Modifier'),
          onPressed: () => _showEditDialog(context),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final originalContext = context;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Violant à supprimer:'),
            const SizedBox(height: 8),
            Text('Nom: ${violant.nom}'),
            Text('Prénom: ${violant.prenom}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _confirmDelete(originalContext);
            },
            child: const Text('Confirmer'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    Navigator.of(context).pop();
    if (controller != null && violant.id != null) {
      controller!.deleteViolant(violant.id!, violant).then((result) {
        SnackbarService.showMessage(result, isError: result.contains('Error'));
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage(
          'Controller not available or Violant ID is null',
          isError: true);
    }
  }

  void _showEditDialog(BuildContext context) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => ViolantEditDialog(
        violant: violant,
        controller: controller,
        violantIndex: violantIndex,
        onViolantUpdated: onViolantUpdated,
      ),
    );
  }
}
