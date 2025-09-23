import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/features/agent/controllers/agent_controller.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/services/snackbar_service.dart';

class AgentFormWidget extends StatefulWidget {
  final AgentController? controller;

  const AgentFormWidget({super.key, this.controller});

  @override
  State<AgentFormWidget> createState() => _AgentFormWidgetState();
}

class _AgentFormWidgetState extends State<AgentFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _nom = '';
  late String _prenom = '';
  late String _cin = '';
  late String _tel = '';
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
              _buildTelField(screenSize),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
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
              "Entrer Le Nom d'Agent", Icons.perm_contact_cal, Colors.blue),
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
        decoration: UiService.buildInputDecoration("Entrer le Prénom d'Agent",
            Icons.perm_contact_cal_outlined, Colors.blue),
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
            "Entrer le CIN d'Agent", Icons.credit_card, Colors.blue),
        validator: (value) {
          if (value == null || value.isEmpty) return "SVP entrer Le CIN";
          if (value.length > 12) {
            return "Le CIN ne doit pas dépasser 12 caractères";
          }
          if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
            return "Le CIN ne doit contenir que des lettres majuscules et des chiffres";
          }
          _cin = value;
          return null;
        },
      ),
    );
  }

  Widget _buildTelField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: UiService.buildInputDecoration(
            "Entrer le N°Téle d'Agent", Icons.phone, Colors.blue),
        validator: (value) {
          if (value == null || value.isEmpty) return "SVP entrer Le N°Téle";
          if (value.length != 10) {
            return "Le numéro doit contenir exactement 10 chiffres";
          }
          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
            return "Le numéro ne doit contenir que des chiffres";
          }
          _tel = value;
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
      final agent = Agent(nom: _nom, prenom: _prenom, tel: _tel, cin: _cin);
      _showConfirmationDialog(context, agent);
    }
  }

  void _showConfirmationDialog(BuildContext context, Agent agent) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Agent Details:'),
            const SizedBox(height: 8),
            Text('Nom: ${agent.nom}'),
            Text('Prenom: ${agent.prenom}'),
            Text('Tel: ${agent.tel}'),
            Text('CIN: ${agent.cin}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performCreation(context, agent);
            },
            child: const Text('Confirmer'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  void _performCreation(BuildContext context, Agent agent) {
    if (widget.controller != null) {
      setState(() => _isSubmitting = true);
      widget.controller!.createAgent(agent).then((result) {
        setState(() => _isSubmitting = false);
        SnackbarService.showMessage(result, isError: result.contains('Error'));
        if (!result.contains('Error')) {
          _formKey.currentState?.reset();
          _nom = '';
          _prenom = '';
          _cin = '';
          _tel = '';
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
