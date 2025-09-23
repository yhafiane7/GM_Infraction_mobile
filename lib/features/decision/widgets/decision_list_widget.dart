import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
import 'package:GM_INFRACTION/features/decision/controllers/decision_controller.dart';
import 'package:GM_INFRACTION/features/decision/widgets/decision_details_dialog.dart';

class DecisionListWidget extends StatelessWidget {
  static const String route = "/decision";

  final List<Decision> decisions;
  final DecisionController? controller;

  const DecisionListWidget({super.key, required this.decisions, this.controller});

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
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Decision Prise')),
      DataColumn(label: Text('N°Infraction')),
      DataColumn(label: SizedBox.shrink()),
    ];
  }

  List<DataRow> _buildRows(BuildContext context) {
    return decisions.asMap().entries.map((entry) {
      final index = entry.key;
      final decision = entry.value;
      final displayIndex = index + 1;
      final rowColor = displayIndex.isEven ? Colors.grey[300] : Colors.white;
      return DataRow(
        color: MaterialStateColor.resolveWith((_) => rowColor!),
        cells: [
          DataCell(Text(displayIndex.toString())),
          DataCell(Text(decision.date)),
          DataCell(Text(decision.decisionPrise)),
          DataCell(Text(decision.infractionId.toString())),
          DataCell(Visibility(visible: false, child: Text(decision.id.toString()))),
        ],
        onLongPress: () => _handleLongPress(context, decision, index),
      );
    }).toList();
  }

  void _handleLongPress(BuildContext context, Decision decision, int index) {
    if (controller != null) {
      showDialog(
        context: context,
        builder: (_) => DecisionDetailsDialog(
          decision: decision,
          controller: controller,
          decisionIndex: index,
        ),
      );
    }
  }
}


