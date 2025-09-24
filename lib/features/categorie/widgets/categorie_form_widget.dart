import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';
import 'package:gmsoft_infractions_mobile/features/categorie/controllers/categorie_controller.dart';
import 'package:gmsoft_infractions_mobile/services/ui_service.dart';
import 'package:gmsoft_infractions_mobile/services/snackbar_service.dart';

/// Widget for creating a new category
class CategorieFormWidget extends StatefulWidget {
  final CategorieController? controller;

  const CategorieFormWidget({
    super.key,
    this.controller,
  });

  @override
  State<CategorieFormWidget> createState() => _CategorieFormWidgetState();
}

class _CategorieFormWidgetState extends State<CategorieFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _nom = '';
  late int _degre = 0;
  bool _isSubmitting = false; // ✅ Add loading state

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
              const SizedBox(height: 20),
              _buildDegreField(screenSize),
              const SizedBox(height: 30),
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
            "Entrer Le Nom du Catégorie",
            Icons.category_outlined,
            Colors.blue,
          ),
          onChanged: (value) {
            _nom = value; // ✅ Add this line
          },
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "SVP entrer Le Nom";
            }
            _nom = value;
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDegreField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.1,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: UiService.buildInputDecoration(
          "Entrer la degré du Catégorie",
          Icons.hdr_weak_sharp,
          Colors.blue,
        ),
        onChanged: (value) {
          _degre = int.tryParse(value) ?? 0; // ✅ Add this line
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "SVP entrer La degré";
          }
          final parsedDegre = int.tryParse(value);
          if (parsedDegre == null) {
            return "SVP entrer un nombre valide";
          }
          _degre = parsedDegre;
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton(Size screenSize) {
    return ElevatedButton.icon(
      onPressed: _isSubmitting
          ? null
          : () => _handleSubmit(context), // ✅ Disable when submitting
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          screenSize.width * 0.4,
          screenSize.height * 0.05,
        ),
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      icon: _isSubmitting
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.person_add), // ✅ Show loading indicator
      label:
          Text(_isSubmitting ? 'Ajout...' : 'Ajouter'), // ✅ Show loading text
    );
  }

  void _handleSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final categorie = Categorie(nom: _nom, degre: _degre);
      _showConfirmationDialog(context, categorie);
    }
  }

  void _showConfirmationDialog(BuildContext context, Categorie categorie) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Catégorie Details:'),
              const SizedBox(height: 8),
              Text('Nom: ${categorie.nom}'),
              Text('Degré: ${categorie.degre}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _performCreation(context, categorie);
              },
              child: const Text('Confirmer'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  void _performCreation(BuildContext context, Categorie categorie) {
    if (widget.controller != null) {
      setState(() {
        _isSubmitting = true; // ✅ Set loading state
      });

      widget.controller!.createCategorie(categorie).then((result) {
        setState(() {
          _isSubmitting = false; // ✅ Clear loading state
        });

        SnackbarService.showMessage(
          result,
          isError: result.contains('Error'),
        );

        // Clear form on success
        if (!result.contains('Error')) {
          _formKey.currentState?.reset();
          setState(() {
            _nom = '';
            _degre = 0;
          });
        }
      }).catchError((error) {
        setState(() {
          _isSubmitting = false; // ✅ Clear loading state on error
        });
        SnackbarService.showMessage('Error: $error', isError: true);
      });
    } else {
      SnackbarService.showMessage('Controller not available', isError: true);
    }
  }
}
