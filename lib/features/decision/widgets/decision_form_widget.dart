import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:gmsoft_infractions_mobile/models/decision_model.dart';
import 'package:gmsoft_infractions_mobile/features/decision/controllers/decision_controller.dart';
import 'package:gmsoft_infractions_mobile/services/ui_service.dart';
import 'package:gmsoft_infractions_mobile/services/snackbar_service.dart';

class DecisionFormWidget extends StatefulWidget {
  final DecisionController? controller;

  const DecisionFormWidget({super.key, this.controller});

  @override
  State<DecisionFormWidget> createState() => _DecisionFormWidgetState();
}

class _DecisionFormWidgetState extends State<DecisionFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateInput = TextEditingController();

  late String _date = '';
  late String _decisionPrise = '';
  late int _infractionId = 0;
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
              _buildDateField(screenSize),
              _buildDecisionField(screenSize),
              _buildInfractionIdField(screenSize),
              SizedBox(height: screenSize.height * 0.03),
              _buildSubmitButton(screenSize),
            ],
          ),
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
              "Entrer La Date :", Icons.person, Colors.blue),
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
                _date = _dateInput.text;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildDecisionField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: TextFormField(
        decoration: UiService.buildInputDecoration(
            "Entrer la Decision", Icons.person, Colors.blue),
        validator: (value) {
          if (value == null || value.isEmpty) return "SVP entrer La Decision";
          _decisionPrise = value;
          return null;
        },
      ),
    );
  }

  Widget _buildInfractionIdField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: UiService.buildInputDecoration(
            "Entrer le Numero d'Infraction", Icons.person, Colors.blue),
        validator: (value) {
          if (value == null || value.isEmpty) return "SVP Numero d'Infraction";
          _infractionId = int.parse(value);
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
      final decision = Decision(
        date: _date,
        decisionPrise: _decisionPrise,
        infractionId: _infractionId,
      );
      _showConfirmationDialog(context, decision);
    }
  }

  void _showConfirmationDialog(BuildContext context, Decision decision) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Decision Details:'),
            const SizedBox(height: 8),
            Text('Date: ${decision.date}'),
            Text('Decision Prise: ${decision.decisionPrise}'),
            Text('N°Infraction: ${decision.infractionId}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performCreation(context, decision);
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

  void _performCreation(BuildContext context, Decision decision) {
    if (widget.controller != null) {
      setState(() => _isSubmitting = true);
      widget.controller!.createDecision(decision).then((result) {
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
