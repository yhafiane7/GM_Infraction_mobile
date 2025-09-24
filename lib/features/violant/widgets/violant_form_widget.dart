import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/models/violant_model.dart';
import 'package:gmsoft_infractions_mobile/features/violant/controllers/violant_controller.dart';
import 'package:gmsoft_infractions_mobile/services/ui_service.dart';
import 'package:gmsoft_infractions_mobile/services/snackbar_service.dart';

class ViolantFormWidget extends StatefulWidget {
  final ViolantController? controller;

  const ViolantFormWidget({super.key, this.controller});

  @override
  State<ViolantFormWidget> createState() => _ViolantFormWidgetState();
}

class _ViolantFormWidgetState extends State<ViolantFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _nom = '';
  late String _prenom = '';
  late String _cin = '';
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNomField(screenSize),
              _buildPrenomField(screenSize),
              _buildCinField(screenSize),
              SizedBox(height: screenSize.height * 0.03),
              _buildSubmitButton(screenSize),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNomField(Size screenSize) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: screenSize.width * 0.9,
        height: screenSize.height * 0.1,
        child: TextFormField(
          decoration: UiService.buildInputDecoration(
              "Entrer Le Nom du Violant", Icons.person, Colors.blue),
          validator: (value) {
            if (value == null || value.isEmpty) return "SVP entrer Le Nom";
            _nom = value;
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildPrenomField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: TextFormField(
        decoration: UiService.buildInputDecoration(
            "Entrer le Prénom du Violant", Icons.person, Colors.blue),
        validator: (value) {
          if (value == null || value.isEmpty) return "SVP entrer Le Prénom";
          _prenom = value;
          return null;
        },
      ),
    );
  }

  Widget _buildCinField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: TextFormField(
        decoration: UiService.buildInputDecoration(
            "Entrer le CIN du Violant", Icons.person, Colors.blue),
        validator: (value) {
          if (value == null || value.isEmpty) return "SVP entrer Le CIN";
          _cin = value;
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton(Size screenSize) {
    return ElevatedButton.icon(
      onPressed: _isSubmitting ? null : () => _handleSubmit(context),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenSize.width * 0.4, screenSize.height * 0.05),
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      icon: _isSubmitting
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.person_add),
      label: Text(_isSubmitting ? 'Ajout...' : 'Ajouter'),
    );
  }

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final violant = Violant(nom: _nom, prenom: _prenom, cin: _cin);
      _showConfirmationDialog(context, violant);
    }
  }

  void _showConfirmationDialog(BuildContext context, Violant violant) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Violant Details:'),
            const SizedBox(height: 8),
            Text('Nom: ${violant.nom}'),
            Text('Prenom: ${violant.prenom}'),
            Text('CIN: ${violant.cin}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performCreation(context, violant);
            },
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _performCreation(BuildContext context, Violant violant) {
    if (widget.controller != null) {
      setState(() => _isSubmitting = true);
      widget.controller!.createViolant(violant).then((result) {
        setState(() => _isSubmitting = false);
        SnackbarService.showMessage(result, isError: result.contains('Error'));
        if (!result.contains('Error')) {
          _formKey.currentState?.reset();
          _nom = '';
          _prenom = '';
          _cin = '';
        }
      }).catchError((error) {
        setState(() => _isSubmitting = false);
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage('Controller not available', isError: true);
    }
  }
}
