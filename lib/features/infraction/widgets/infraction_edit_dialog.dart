import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gmsoft_infractions_mobile/models/infraction_model.dart';
import 'package:gmsoft_infractions_mobile/features/infraction/controllers/infraction_controller.dart';
import 'package:gmsoft_infractions_mobile/services/snackbar_service.dart';

class InfractionEditDialog extends StatefulWidget {
  final Infraction infraction;
  final InfractionController? controller;
  final int infractionIndex;
  final Function(int, Infraction)? onInfractionUpdated;

  const InfractionEditDialog({
    super.key,
    required this.infraction,
    this.controller,
    required this.infractionIndex,
    this.onInfractionUpdated,
  });

  @override
  State<InfractionEditDialog> createState() => _InfractionEditDialogState();
}

class _InfractionEditDialogState extends State<InfractionEditDialog> {
  late TextEditingController _nomController;
  late TextEditingController _dateController;
  late TextEditingController _adresseController;
  late TextEditingController _communeIdController;
  late TextEditingController _violantIdController;
  late TextEditingController _agentIdController;
  late TextEditingController _categorieIdController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.infraction.nom);
    _dateController = TextEditingController(text: widget.infraction.date);
    _adresseController = TextEditingController(text: widget.infraction.adresse);
    _communeIdController =
        TextEditingController(text: widget.infraction.commune_id.toString());
    _violantIdController =
        TextEditingController(text: widget.infraction.violant_id.toString());
    _agentIdController =
        TextEditingController(text: widget.infraction.agent_id.toString());
    _categorieIdController =
        TextEditingController(text: widget.infraction.categorie_id.toString());
    _latitudeController =
        TextEditingController(text: widget.infraction.latitude.toString());
    _longitudeController =
        TextEditingController(text: widget.infraction.longitude.toString());
  }

  @override
  void dispose() {
    _nomController.dispose();
    _dateController.dispose();
    _adresseController.dispose();
    _communeIdController.dispose();
    _violantIdController.dispose();
    _agentIdController.dispose();
    _categorieIdController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
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
              Expanded(
                child: SingleChildScrollView(
                  child: _buildForm(),
                ),
              ),
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
          controller: _adresseController,
          decoration: const InputDecoration(
            labelText: 'Adresse',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _communeIdController,
          decoration: const InputDecoration(
            labelText: 'Commune',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _violantIdController,
          decoration: const InputDecoration(
            labelText: 'Violant',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _agentIdController,
          decoration: const InputDecoration(
            labelText: 'Agent',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _categorieIdController,
          decoration: const InputDecoration(
            labelText: 'Categorie',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _latitudeController,
          decoration: const InputDecoration(
            labelText: 'Latitude',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _longitudeController,
          decoration: const InputDecoration(
            labelText: 'Longitude',
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
    if (widget.controller != null && widget.infraction.id != null) {
      final updated = Infraction(
        id: widget.infraction.id,
        nom: _nomController.text,
        date: _dateController.text,
        adresse: _adresseController.text,
        commune_id: int.tryParse(_communeIdController.text) ??
            widget.infraction.commune_id,
        violant_id: int.tryParse(_violantIdController.text) ??
            widget.infraction.violant_id,
        agent_id:
            int.tryParse(_agentIdController.text) ?? widget.infraction.agent_id,
        categorie_id: int.tryParse(_categorieIdController.text) ??
            widget.infraction.categorie_id,
        latitude: double.tryParse(_latitudeController.text) ??
            widget.infraction.latitude,
        longitude: double.tryParse(_longitudeController.text) ??
            widget.infraction.longitude,
      );
      widget.controller!
          .updateInfraction(widget.infractionIndex, updated)
          .then((result) {
        Navigator.of(context).pop();
        SnackbarService.showMessage(result, isError: result.contains('Error'));
        if (!result.contains('Error') && widget.onInfractionUpdated != null) {
          widget.onInfractionUpdated!(widget.infractionIndex, updated);
        }
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage('Controller not available', isError: true);
    }
  }
}
