import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/features/infraction/controllers/infraction_controller.dart';
import 'package:GM_INFRACTION/services/snackbar_service.dart';
import 'package:GM_INFRACTION/features/infraction/widgets/infraction_edit_dialog.dart';

class InfractionDetailsDialog extends StatelessWidget {
  final Infraction infraction;
  final InfractionController? controller;
  final int infractionIndex;
  final Function(int, Infraction)? onInfractionUpdated;

  const InfractionDetailsDialog({
    super.key,
    required this.infraction,
    this.controller,
    required this.infractionIndex,
    this.onInfractionUpdated,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nom: ${infraction.nom}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Date: ${infraction.date}'),
        Text('Adresse: ${infraction.adresse}'),
        Text('Commune: ${infraction.commune_id}'),
        Text('Violant: ${infraction.violant_id}'),
        Text('Agent: ${infraction.agent_id}'),
        Text('Catégorie: ${infraction.categorie_id}'),
        Text('Latitude: ${infraction.latitude}'),
        Text('Longitude: ${infraction.longitude}'),
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
            const Text('Infraction à supprimer:'),
            const SizedBox(height: 8),
            Text('Nom: ${infraction.nom}'),
            Text('Latitude: ${infraction.latitude}'),
            Text('Longitude: ${infraction.longitude}'),
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
    if (controller != null && infraction.id != null) {
      controller!.deleteInfraction(infraction.id!, infraction).then((result) {
        SnackbarService.showMessage(result, isError: result.contains('Error'));
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage(
          'Controller not available or Infraction ID is null',
          isError: true);
    }
  }

  void _showEditDialog(BuildContext context) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => InfractionEditDialog(
        infraction: infraction,
        controller: controller,
        infractionIndex: infractionIndex,
        onInfractionUpdated: onInfractionUpdated,
      ),
    );
  }
}
