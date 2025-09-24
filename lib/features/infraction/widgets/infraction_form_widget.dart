import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';
import 'package:gmsoft_infractions_mobile/models/commune_model.dart';
import 'package:gmsoft_infractions_mobile/models/violant_model.dart';
import 'package:gmsoft_infractions_mobile/models/infraction_model.dart';
import 'package:gmsoft_infractions_mobile/features/infraction/controllers/infraction_controller.dart';
import 'package:gmsoft_infractions_mobile/services/ui_service.dart';
import 'package:gmsoft_infractions_mobile/services/snackbar_service.dart';

class InfractionFormWidget extends StatefulWidget {
  final List<Commune> communes;
  final List<Violant> violants;
  final List<Agent> agents;
  final List<Categorie> categories;
  final InfractionController? controller;

  const InfractionFormWidget({
    super.key,
    required this.communes,
    required this.violants,
    required this.agents,
    required this.categories,
    this.controller,
  });

  @override
  State<InfractionFormWidget> createState() => _InfractionFormWidgetState();
}

class _InfractionFormWidgetState extends State<InfractionFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateInput = TextEditingController();

  late String _nom;
  late String _adresse;
  late int _communeId = 0;
  late int _violantId = 0;
  late int _agentId = 0;
  late int _categorieId = 0;
  late double _latitude;
  late double _longitude;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            _buildNomField(screenSize),
            _buildDateField(screenSize),
            _buildAdresseField(screenSize),
            _buildCommuneDropdown(screenSize),
            _buildViolantDropdown(screenSize),
            _buildAgentDropdown(screenSize),
            _buildCategorieDropdown(screenSize),
            _buildLatitudeField(screenSize),
            _buildLongitudeField(screenSize),
            SizedBox(height: screenSize.height * 0.03),
            _buildSubmitButton(screenSize),
          ],
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
              "Entrer Le Nom", Icons.perm_contact_cal_outlined, Colors.blue),
          validator: (value) {
            if (value == null || value.isEmpty) return "SVP Entrer Le Nom ";
            _nom = value;
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDateField(Size screenSize) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: screenSize.width * 0.9,
        height: screenSize.height * 0.1,
        child: TextFormField(
          keyboardType: TextInputType.datetime,
          controller: _dateInput,
          readOnly: true,
          decoration: UiService.buildInputDecoration(
              "Entrer La Date", Icons.date_range, Colors.blue),
          validator: (value) {
            if (value == null || value.isEmpty) return "SVP entrer La Date";
            return null;
          },
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
                _dateInput.text = DateFormat('yyyy-MM-dd').format(selectedDate);
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildAdresseField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: TextFormField(
        keyboardType: TextInputType.streetAddress,
        decoration: UiService.buildInputDecoration(
            "Entrer l'adresse:  ", Icons.location_on_outlined, Colors.blue),
        validator: (value) {
          if (value == null || value.isEmpty) return "SVP entrer une adresse";
          _adresse = value;
          return null;
        },
      ),
    );
  }

  Widget _buildCommuneDropdown(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: DropdownButtonFormField<Commune>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.5),
          ),
          filled: true,
          fillColor: Colors.blue[50],
          labelText: 'Commune',
        ),
        value: _communeId != 0
            ? widget.communes.firstWhereOrNull((c) => c.id == _communeId)
            : null,
        onChanged: (Commune? newValue) {
          if (newValue != null) {
            setState(() => _communeId = newValue.id!);
          }
        },
        items: widget.communes
            .map<DropdownMenuItem<Commune>>((commune) => DropdownMenuItem(
                  value: commune,
                  child: Text(commune.nom),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildViolantDropdown(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: DropdownButtonFormField<Violant>(
        menuMaxHeight: screenSize.height * 0.3,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.5),
          ),
          labelText: 'Violent',
          filled: true,
          fillColor: Colors.blue[50],
        ),
        value: _violantId != 0
            ? widget.violants.firstWhereOrNull((v) => v.id == _violantId)
            : null,
        onChanged: (Violant? newValue) {
          if (newValue != null) {
            setState(() => _violantId = newValue.id!);
          }
        },
        items: widget.violants
            .map<DropdownMenuItem<Violant>>((violant) => DropdownMenuItem(
                  value: violant,
                  child: Text("${violant.nom} ${violant.prenom}"),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildAgentDropdown(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: DropdownButtonFormField<Agent>(
        menuMaxHeight: screenSize.height * 0.3,
        decoration: InputDecoration(
          labelText: 'Agent',
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.5),
          ),
          filled: true,
          fillColor: Colors.blue[50],
        ),
        value: _agentId != 0
            ? widget.agents.firstWhereOrNull((a) => a.id == _agentId)
            : null,
        onChanged: (Agent? newValue) {
          if (newValue != null) {
            setState(() => _agentId = newValue.id!);
          }
        },
        items: widget.agents
            .map<DropdownMenuItem<Agent>>((agent) => DropdownMenuItem(
                  value: agent,
                  child: Text("${agent.nom} ${agent.prenom}"),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCategorieDropdown(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: DropdownButtonFormField<Categorie>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.5),
          ),
          filled: true,
          fillColor: Colors.blue[50],
          labelText: 'Categorie',
        ),
        value: _categorieId != 0
            ? widget.categories.firstWhereOrNull((c) => c.id == _categorieId)
            : null,
        onChanged: (Categorie? newValue) {
          if (newValue != null) {
            setState(() => _categorieId = newValue.id!);
          }
        },
        items: widget.categories
            .map<DropdownMenuItem<Categorie>>((cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(cat.nom),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildLatitudeField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^[-0-9.]+$'))
        ],
        decoration: UiService.buildInputDecoration(
            "Entrer la latitude", Icons.gps_fixed_outlined, Colors.blue),
        validator: (value) {
          if (value == null || value.isEmpty) return "SVP entrer La latitude";
          _latitude = double.parse(value);
          return null;
        },
      ),
    );
  }

  Widget _buildLongitudeField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^[-0-9.]+$')),
        ],
        decoration: UiService.buildInputDecoration(
            "Entrer la longitude", Icons.gps_fixed_outlined, Colors.blue),
        validator: (value) {
          if (value == null || value.isEmpty) return "SVP entrer La longitude";
          _longitude = double.parse(value);
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
      final infraction = Infraction(
        nom: _nom,
        date: _dateInput.text,
        adresse: _adresse,
        commune_id: _communeId,
        violant_id: _violantId,
        agent_id: _agentId,
        categorie_id: _categorieId,
        latitude: _latitude,
        longitude: _longitude,
      );
      _showConfirmationDialog(context, infraction);
    }
  }

  void _showConfirmationDialog(BuildContext context, Infraction infraction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Infraction Details:'),
            const SizedBox(height: 8),
            Text('Nom: ${infraction.nom}'),
            Text('Date: ${infraction.date}'),
            Text('Adresse: ${infraction.adresse}'),
            Text('Commune: ${infraction.commune_id}'),
            Text('Violant: ${infraction.violant_id}'),
            Text('Agent: ${infraction.agent_id}'),
            Text('Catégorie: ${infraction.categorie_id}'),
            Text('Latitude: ${infraction.latitude}'),
            Text('Longitude: ${infraction.longitude}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performCreation(context, infraction);
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

  void _performCreation(BuildContext context, Infraction infraction) {
    if (widget.controller != null) {
      setState(() => _isSubmitting = true);
      widget.controller!.createInfraction(infraction).then((result) {
        setState(() => _isSubmitting = false);
        SnackbarService.showMessage(result, isError: result.contains('Error'));
        if (!result.contains('Error')) {
          _formKey.currentState?.reset();
          _dateInput.clear();
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
