import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/models/categorie_model.dart';
import 'package:gmsoft_infractions_mobile/features/categorie/controllers/categorie_controller.dart';
import 'package:gmsoft_infractions_mobile/features/categorie/widgets/categorie_details_dialog.dart';

/// Widget for displaying a list of categories in a DataTable
class CategorieListWidget extends StatelessWidget {
  static const String route = "/categorie";

  final List<Categorie> categories;
  final CategorieController? controller;

  const CategorieListWidget({
    super.key,
    required this.categories,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: _buildColumns(context),
              rows: _buildRows(context),
            ),
          ),
        ),
      ],
    );
  }

  /// Build table columns
  List<DataColumn> _buildColumns(BuildContext context) {
    return [
      DataColumn(
        label: SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: const Text('ID'),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: const Text('Nom'),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: const Text('Degre'),
        ),
      ),
      const DataColumn(
        label: SizedBox.shrink(),
      ),
    ];
  }

  /// Build table rows using server categories
  List<DataRow> _buildRows(BuildContext context) {
    return categories.asMap().entries.map((entry) {
      final index = entry.key;
      final categorie = entry.value;
      final displayIndex = index + 1;
      final rowColor = displayIndex.isEven ? Colors.grey[300] : Colors.white;

      return DataRow(
        color: MaterialStateColor.resolveWith((states) => rowColor!),
        cells: [
          DataCell(Text(displayIndex.toString())),
          DataCell(Text(categorie.nom)),
          DataCell(Text(categorie.degre.toString())),
          DataCell(
            Visibility(
              visible: false,
              child: Text(categorie.id.toString()),
            ),
          ),
        ],
        onLongPress: () => _handleLongPress(context, categorie, index),
      );
    }).toList();
  }

  /// Handle long press on category row
  void _handleLongPress(BuildContext context, Categorie categorie, int index) {
    if (controller != null) {
      _showCategoryDetailsDialog(context, categorie, index); // ✅ Pass index
    }
  }

  /// Show category details dialog with edit/delete options
  void _showCategoryDetailsDialog(
      BuildContext context, Categorie categorie, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategorieDetailsDialog(
          categorie: categorie,
          controller: controller,
          categoryIndex: index, // ✅ Pass index to dialog
          onCategoryUpdated: null, // ✅ Pass the update method
        );
      },
    );
  }
}
