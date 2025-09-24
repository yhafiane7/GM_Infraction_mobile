import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'package:gmsoft_infractions_mobile/features/agent/controllers/agent_controller.dart';
import 'package:gmsoft_infractions_mobile/services/snackbar_service.dart';
import 'package:gmsoft_infractions_mobile/features/agent/widgets/agent_edit_dialog.dart';

class AgentDetailsDialog extends StatelessWidget {
  final Agent agent;
  final AgentController? controller;
  final int agentIndex;
  final Function(int, Agent)? onAgentUpdated;

  const AgentDetailsDialog({
    super.key,
    required this.agent,
    this.controller,
    required this.agentIndex,
    this.onAgentUpdated,
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
        Text('Nom: ${agent.nom}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Prénom: ${agent.prenom}'),
        Text('CIN: ${agent.cin}'),
        Text('N°Téle: ${agent.tel}'),
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
            const Text('Agent à supprimer:'),
            const SizedBox(height: 8),
            Text('Nom: ${agent.nom}'),
            Text('Prénom: ${agent.prenom}'),
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
    if (controller != null && agent.id != null) {
      controller!.deleteAgent(agent.id!, agent).then((result) {
        SnackbarService.showMessage(result, isError: result.contains('Error'));
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage(
          'Controller not available or Agent ID is null',
          isError: true);
    }
  }

  void _showEditDialog(BuildContext context) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => AgentEditDialog(
        agent: agent,
        controller: controller,
        agentIndex: agentIndex,
        onAgentUpdated: onAgentUpdated,
      ),
    );
  }
}
