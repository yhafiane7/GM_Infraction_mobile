import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/features/commune/controllers/commune_controller.dart';
import 'package:GM_INFRACTION/services/snackbar_service.dart';

/// Dialog for editing commune
class CommuneEditDialog extends StatefulWidget {
  final Commune commune;
  final CommuneController? controller;
  final int communeIndex;
  final Function(int, Commune)? onCommuneUpdated;

  const CommuneEditDialog({
    super.key,
    required this.commune,
    this.controller,
    required this.communeIndex,
    this.onCommuneUpdated,
  });

  @override
  State<CommuneEditDialog> createState() => _CommuneEditDialogState();
}

class _CommuneEditDialogState extends State<CommuneEditDialog> {
  late TextEditingController _nomController;
  late TextEditingController _caidatController;
  late TextEditingController _pachalikCirconController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.commune.nom);
    _caidatController = TextEditingController(text: widget.commune.caidat);
    _pachalikCirconController =
        TextEditingController(text: widget.commune.pachalikcircon);
    _latitudeController =
        TextEditingController(text: widget.commune.latitude.toString());
    _longitudeController =
        TextEditingController(text: widget.commune.longitude.toString());
  }

  @override
  void dispose() {
    _nomController.dispose();
    _caidatController.dispose();
    _pachalikCirconController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
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
          controller: _caidatController,
          decoration: const InputDecoration(
            labelText: 'Caidat',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _pachalikCirconController,
          decoration: const InputDecoration(
            labelText: 'Pachalik/Circon',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _latitudeController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Latitude',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _longitudeController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Longitude',
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
    if (widget.controller != null && widget.commune.id != null) {
      final updatedCommune = Commune(
        id: widget.commune.id,
        nom: _nomController.text,
        caidat: _caidatController.text,
        pachalikcircon: _pachalikCirconController.text,
        latitude: double.tryParse(_latitudeController.text) ??
            widget.commune.latitude,
        longitude: double.tryParse(_longitudeController.text) ??
            widget.commune.longitude,
      );

      widget.controller!
          .updateCommune(widget.communeIndex, updatedCommune)
          .then((result) {
        Navigator.of(context).pop();
        SnackbarService.showMessage(result, isError: result.contains('Error'));

        if (!result.contains('Error') && widget.onCommuneUpdated != null) {
          widget.onCommuneUpdated!(widget.communeIndex, updatedCommune);
        }
      }).catchError((error) {
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage('Controller not available', isError: true);
    }
  }
}
