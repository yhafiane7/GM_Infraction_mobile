import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/features/violant/controllers/violant_controller.dart';
import 'package:GM_INFRACTION/features/violant/widgets/violant_details_dialog.dart';

class ViolantListWidget extends StatelessWidget {
  static const String route = "/violant";

  final List<Violant> violants;
  final ViolantController? controller;

  const ViolantListWidget({super.key, required this.violants, this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              sortColumnIndex: 0,
              columns: _buildColumns(context),
              rows: _buildRows(context),
            ),
          ),
        ),
      ],
    );
  }

  List<DataColumn> _buildColumns(BuildContext context) {
    return const [
      DataColumn(numeric: true, label: Text('ID')),
      DataColumn(label: Text('Nom')),
      DataColumn(label: Text('Prénom')),
      DataColumn(label: Text('CIN')),
      DataColumn(label: SizedBox.shrink()),
    ];
  }

  List<DataRow> _buildRows(BuildContext context) {
    return violants.asMap().entries.map((entry) {
      final index = entry.key;
      final violant = entry.value;
      final displayIndex = index + 1;
      final rowColor = displayIndex.isEven ? Colors.grey[300] : Colors.white;
      return DataRow(
        color: MaterialStateColor.resolveWith((states) => rowColor!),
        cells: [
          DataCell(Text(displayIndex.toString())),
          DataCell(Text(violant.nom)),
          DataCell(Text(violant.prenom)),
          DataCell(Text(violant.cin)),
          DataCell(
              Visibility(visible: false, child: Text(violant.id.toString()))),
        ],
        onLongPress: () => _handleLongPress(context, violant, index),
      );
    }).toList();
  }

  void _handleLongPress(BuildContext context, Violant violant, int index) {
    if (controller != null) {
      showDialog(
        context: context,
        builder: (_) => ViolantDetailsDialog(
          violant: violant,
          controller: controller,
          violantIndex: index,
        ),
      );
    }
  }
}
