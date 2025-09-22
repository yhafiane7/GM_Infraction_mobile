import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/features/commune/controllers/commune_controller.dart';
import 'package:GM_INFRACTION/services/snackbar_service.dart';
import 'package:GM_INFRACTION/features/commune/widgets/commune_edit_dialog.dart';

/// Dialog for showing commune details and actions
class CommuneDetailsDialog extends StatelessWidget {
  final Commune commune;
  final CommuneController? controller;
  final int communeIndex;
  final Function(int, Commune)? onCommuneUpdated;

  const CommuneDetailsDialog({
    super.key,
    required this.commune,
    this.controller,
    required this.communeIndex,
    this.onCommuneUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Dialog.fullscreen(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCommuneDetails(),
              const SizedBox(height: 20),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommuneDetails() {
    return Column(
      children: [
        Text('Nom: ${commune.nom}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Caidat: ${commune.caidat}'),
        Text('Pachalik/Circon: ${commune.pachalikcircon}'),
        Text('Latitude: ${commune.latitude}'),
        Text('Longitude: ${commune.longitude}'),
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
            const Text('Commune à supprimer:'),
            const SizedBox(height: 8),
            Text('Nom: ${commune.nom}'),
            Text('Caidat: ${commune.caidat}'),
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
    if (controller != null && commune.id != null) {
      controller!.deleteCommune(commune.id!, commune).then((result) {
        SnackbarService.showMessage(result, isError: result.contains('Error'));
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage(
          'Controller not available or Commune ID is null',
          isError: true);
    }
  }

  void _showEditDialog(BuildContext context) {
    Navigator.of(context).pop(); // Close details dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommuneEditDialog(
          commune: commune,
          controller: controller,
          communeIndex: communeIndex,
          onCommuneUpdated: onCommuneUpdated,
        );
      },
    );
  }
}
