import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/features/infraction/controllers/infraction_controller.dart';
import 'package:GM_INFRACTION/features/infraction/widgets/infraction_details_dialog.dart';

class InfractionListWidget extends StatelessWidget {
  static const String route = "/infraction";

  final List<Infraction> infractions;
  final InfractionController? controller;

  const InfractionListWidget({super.key, required this.infractions, this.controller});

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

  List<DataColumn> _buildColumns(BuildContext context) {
    return const [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Nom')),
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Adresse')),
      DataColumn(label: Text('Commune')),
      DataColumn(label: Text('Violant')),
      DataColumn(label: Text('Agent')),
      DataColumn(label: Text('Categorie')),
      DataColumn(label: Text('Latitude')),
      DataColumn(label: Text('Longitude')),
      DataColumn(label: SizedBox.shrink()),
    ];
  }

  List<DataRow> _buildRows(BuildContext context) {
    return infractions.asMap().entries.map((entry) {
      final index = entry.key;
      final infraction = entry.value;
      final displayIndex = index + 1;
      final rowColor = displayIndex.isEven ? Colors.grey[300] : Colors.white;
      return DataRow(
        color: MaterialStateColor.resolveWith((_) => rowColor!),
        cells: [
          DataCell(Text(displayIndex.toString())),
          DataCell(Text(infraction.nom)),
          DataCell(Text(infraction.date)),
          DataCell(Text(infraction.adresse)),
          DataCell(Text(infraction.commune_id.toString())),
          DataCell(Text(infraction.violant_id.toString())),
          DataCell(Text(infraction.agent_id.toString())),
          DataCell(Text(infraction.categorie_id.toString())),
          DataCell(Text(infraction.latitude.toString())),
          DataCell(Text(infraction.longitude.toString())),
          DataCell(Visibility(visible: false, child: Text(infraction.id.toString()))),
        ],
        onLongPress: () => _handleLongPress(context, infraction, index),
      );
    }).toList();
  }

  void _handleLongPress(BuildContext context, Infraction infraction, int index) {
    if (controller != null) {
      showDialog(
        context: context,
        builder: (_) => InfractionDetailsDialog(
          infraction: infraction,
          controller: controller,
          infractionIndex: index,
        ),
      );
    }
  }
}


