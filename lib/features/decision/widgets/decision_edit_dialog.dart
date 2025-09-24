import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gmsoft_infractions_mobile/models/decision_model.dart';
import 'package:gmsoft_infractions_mobile/features/decision/controllers/decision_controller.dart';
import 'package:gmsoft_infractions_mobile/services/snackbar_service.dart';

class DecisionEditDialog extends StatefulWidget {
  final Decision decision;
  final DecisionController? controller;
  final int decisionIndex;
  final Function(int, Decision)? onDecisionUpdated;

  const DecisionEditDialog({
    super.key,
    required this.decision,
    this.controller,
    required this.decisionIndex,
    this.onDecisionUpdated,
  });

  @override
  State<DecisionEditDialog> createState() => _DecisionEditDialogState();
}

class _DecisionEditDialogState extends State<DecisionEditDialog> {
  late TextEditingController _dateController;
  late TextEditingController _decisionController;
  late TextEditingController _infractionIdController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.decision.date);
    _decisionController =
        TextEditingController(text: widget.decision.decisionPrise);
    _infractionIdController =
        TextEditingController(text: widget.decision.infractionId.toString());
  }

  @override
  void dispose() {
    _dateController.dispose();
    _decisionController.dispose();
    _infractionIdController.dispose();
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
          controller: _dateController,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Date',
            border: OutlineInputBorder(),
          ),
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              cancelText: 'Annuler',
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2040),
            );
            if (selectedDate != null) {
              setState(() {
                _dateController.text =
                    DateFormat('yyyy-MM-dd').format(selectedDate);
              });
            }
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _decisionController,
          decoration: const InputDecoration(
            labelText: 'Decision',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _infractionIdController,
          decoration: const InputDecoration(
            labelText: "N°Infraction",
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
    if (widget.controller != null && widget.decision.id != null) {
      final updated = Decision(
        id: widget.decision.id,
        date: _dateController.text,
        decisionPrise: _decisionController.text,
        infractionId: int.tryParse(_infractionIdController.text) ??
            widget.decision.infractionId,
      );
      widget.controller!
          .updateDecision(widget.decisionIndex, updated)
          .then((result) {
        Navigator.of(context).pop();
        SnackbarService.showMessage(result, isError: result.contains('Error'));
        if (!result.contains('Error') && widget.onDecisionUpdated != null) {
          widget.onDecisionUpdated!(widget.decisionIndex, updated);
        }
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage('Controller not available', isError: true);
    }
  }
}
