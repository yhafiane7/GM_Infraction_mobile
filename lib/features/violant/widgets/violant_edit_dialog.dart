import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/features/violant/controllers/violant_controller.dart';
import 'package:GM_INFRACTION/services/snackbar_service.dart';

class ViolantEditDialog extends StatefulWidget {
  final Violant violant;
  final ViolantController? controller;
  final int violantIndex;
  final Function(int, Violant)? onViolantUpdated;

  const ViolantEditDialog({
    super.key,
    required this.violant,
    this.controller,
    required this.violantIndex,
    this.onViolantUpdated,
  });

  @override
  State<ViolantEditDialog> createState() => _ViolantEditDialogState();
}

class _ViolantEditDialogState extends State<ViolantEditDialog> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _cinController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.violant.nom);
    _prenomController = TextEditingController(text: widget.violant.prenom);
    _cinController = TextEditingController(text: widget.violant.cin);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _cinController.dispose();
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
    if (widget.controller != null && widget.violant.id != null) {
      final updated = Violant(
        id: widget.violant.id,
        nom: _nomController.text,
        prenom: _prenomController.text,
        cin: _cinController.text,
      );
      widget.controller!
          .updateViolant(widget.violantIndex, updated)
          .then((result) {
        Navigator.of(context).pop();
        SnackbarService.showMessage(result, isError: result.contains('Error'));
        if (!result.contains('Error') && widget.onViolantUpdated != null) {
          widget.onViolantUpdated!(widget.violantIndex, updated);
        }
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage('Controller not available', isError: true);
    }
  }
}


