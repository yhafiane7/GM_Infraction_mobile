import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/features/commune/controllers/commune_controller.dart';
import 'package:GM_INFRACTION/features/commune/widgets/commune_details_dialog.dart';

class CommuneListWidget extends StatelessWidget {
  static const String route = "/commune";
  final List<Commune> communes;
  final CommuneController? controller;

  const CommuneListWidget({super.key, required this.communes, this.controller});

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
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Nom')),
      const DataColumn(label: Text('Caidat')),
      const DataColumn(label: Text('Pachalik/Circon')),
      const DataColumn(label: Text('Latitude')),
      const DataColumn(label: Text('Longitude')),
      const DataColumn(label: SizedBox.shrink()),
    ];
  }

  List<DataRow> _buildRows(BuildContext context) {
    return communes.asMap().entries.map((entry) {
      final index = entry.key;
      final commune = entry.value;
      final displayIndex = index + 1;
      final rowColor = displayIndex.isEven ? Colors.grey[300] : Colors.white;

      return DataRow(
        color: MaterialStateColor.resolveWith((_) => rowColor!),
        cells: [
          DataCell(Text(displayIndex.toString())),
          DataCell(Text(commune.nom)),
          DataCell(Text(commune.caidat)),
          DataCell(Text(commune.pachalikcircon)),
          DataCell(Text(commune.latitude.toString())),
          DataCell(Text(commune.longitude.toString())),
          DataCell(
              Visibility(visible: false, child: Text(commune.id.toString()))),
        ],
        onLongPress: () => _handleLongPress(context, commune, index),
      );
    }).toList();
  }

  void _handleLongPress(BuildContext context, Commune commune, int index) {
    if (controller != null) {
      showDialog(
        context: context,
        builder: (_) => CommuneDetailsDialog(
          commune: commune,
          controller: controller,
          communeIndex: index,
        ),
      );
    }
  }
}
