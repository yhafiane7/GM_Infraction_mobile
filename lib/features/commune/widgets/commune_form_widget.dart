import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/features/commune/controllers/commune_controller.dart';
import 'package:GM_INFRACTION/services/ui_service.dart';
import 'package:GM_INFRACTION/services/snackbar_service.dart';

class CommuneFormWidget extends StatefulWidget {
  final CommuneController? controller;
  const CommuneFormWidget({super.key, this.controller});

  @override
  State<CommuneFormWidget> createState() => _CommuneFormWidgetState();
}

class _CommuneFormWidgetState extends State<CommuneFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _nom = '';
  String _caidat = '';
  String _pachalik = '';
  double? _latitude;
  double? _longitude;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildText(screen, 'Nom', Icons.location_city, (v) => _nom = v,
                  (v) => v == null || v.isEmpty ? 'SVP entrer Le Nom' : null),
              _buildText(
                  screen,
                  'Caidat',
                  Icons.admin_panel_settings,
                  (v) => _caidat = v,
                  (v) =>
                      v == null || v.isEmpty ? 'SVP entrer La Caidat' : null),
              _buildText(
                  screen,
                  'Pachalik/Circon',
                  Icons.account_tree,
                  (v) => _pachalik = v,
                  (v) => v == null || v.isEmpty
                      ? 'SVP entrer Le Pachalik/Circon'
                      : null),
              _buildNumber(
                  screen,
                  'Latitude',
                  Icons.explore,
                  (v) => _latitude = double.tryParse(v ?? ''),
                  (v) => (double.tryParse(v ?? '') == null)
                      ? 'SVP entrer une latitude valide'
                      : null),
              _buildNumber(
                  screen,
                  'Longitude',
                  Icons.explore_outlined,
                  (v) => _longitude = double.tryParse(v ?? ''),
                  (v) => (double.tryParse(v ?? '') == null)
                      ? 'SVP entrer une longitude valide'
                      : null),
              const SizedBox(height: 20),
              _buildSubmit(screen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(Size s, String label, IconData icon,
      Function(String) onChanged, String? Function(String?) validator) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: s.width * 0.9,
        height: s.height * 0.1,
        child: TextFormField(
          decoration: UiService.buildInputDecoration(
              'Entrer $label', icon, Colors.blue),
          onChanged: (v) => onChanged(v),
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildNumber(Size s, String label, IconData icon,
      Function(String?) onChanged, String? Function(String?) validator) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: s.width * 0.9,
        height: s.height * 0.1,
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.-]'))
          ],
          decoration: UiService.buildInputDecoration(
              'Entrer $label', icon, Colors.blue),
          onChanged: (v) => onChanged(v),
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildSubmit(Size s) {
    return ElevatedButton.icon(
      onPressed: _isSubmitting ? null : () => _handleSubmit(context),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(s.width * 0.4, s.height * 0.05),
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      icon: _isSubmitting
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2))
          : const Icon(Icons.add_location_alt_outlined),
      label: Text(_isSubmitting ? 'Ajout...' : 'Ajouter'),
    );
  }

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final commune = Commune(
        nom: _nom,
        caidat: _caidat,
        pachalikcircon: _pachalik,
        latitude: _latitude!,
        longitude: _longitude!,
      );
      _showConfirm(context, commune);
    }
  }

  void _showConfirm(BuildContext context, Commune commune) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Commune Details:'),
            const SizedBox(height: 8),
            Text('Nom: ${commune.nom}'),
            Text('Caidat: ${commune.caidat}'),
            Text('Pachalik/Circon: ${commune.pachalikcircon}'),
            Text('Latitude: ${commune.latitude}'),
            Text('Longitude: ${commune.longitude}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performCreate(context, commune);
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

  void _performCreate(BuildContext context, Commune commune) {
    if (widget.controller != null) {
      setState(() => _isSubmitting = true);
      widget.controller!.createCommune(commune).then((result) {
        setState(() => _isSubmitting = false);
        SnackbarService.showMessage(result, isError: result.contains('Error'));
        if (!result.contains('Error')) {
          _formKey.currentState?.reset();
          _nom = '';
          _caidat = '';
          _pachalik = '';
          _latitude = null;
          _longitude = null;
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
