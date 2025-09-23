import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/features/agent/controllers/agent_controller.dart';
import 'package:GM_INFRACTION/services/snackbar_service.dart';

class AgentEditDialog extends StatefulWidget {
  final Agent agent;
  final AgentController? controller;
  final int agentIndex;
  final Function(int, Agent)? onAgentUpdated;

  const AgentEditDialog({
    super.key,
    required this.agent,
    this.controller,
    required this.agentIndex,
    this.onAgentUpdated,
  });

  @override
  State<AgentEditDialog> createState() => _AgentEditDialogState();
}

class _AgentEditDialogState extends State<AgentEditDialog> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _cinController;
  late TextEditingController _telController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.agent.nom);
    _prenomController = TextEditingController(text: widget.agent.prenom);
    _cinController = TextEditingController(text: widget.agent.cin);
    _telController = TextEditingController(text: widget.agent.tel);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _cinController.dispose();
    _telController.dispose();
    super.dispose();
  }

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
              _buildForm(),
              const SizedBox(height: 20),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
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
          controller: _prenomController,
          decoration: const InputDecoration(
            labelText: 'Prénom',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cinController,
          decoration: const InputDecoration(
            labelText: 'CIN',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _telController,
          decoration: const InputDecoration(
            labelText: 'N°Téle',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
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
          onPressed: () => Navigator.of(context).pop(),
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
    if (widget.controller != null && widget.agent.id != null) {
      final updated = Agent(
        id: widget.agent.id,
        nom: _nomController.text,
        prenom: _prenomController.text,
        cin: _cinController.text,
        tel: _telController.text,
      );
      widget.controller!.updateAgent(widget.agentIndex, updated).then((result) {
        Navigator.of(context).pop();
        SnackbarService.showMessage(result, isError: result.contains('Error'));
        if (!result.contains('Error') && widget.onAgentUpdated != null) {
          widget.onAgentUpdated!(widget.agentIndex, updated);
        }
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage('Controller not available', isError: true);
    }
  }
}
