import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/models/agent_model.dart';
import 'package:gmsoft_infractions_mobile/features/agent/controllers/agent_controller.dart';
import 'package:gmsoft_infractions_mobile/features/agent/widgets/agent_details_dialog.dart';

class AgentListWidget extends StatelessWidget {
  static const String route = "/agent";

  final List<Agent> agents;
  final AgentController? controller;

  const AgentListWidget({super.key, required this.agents, this.controller});

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
      DataColumn(label: Text('Prénom')),
      DataColumn(label: Text('CIN')),
      DataColumn(label: Text('N.Télé')),
      DataColumn(label: SizedBox.shrink()),
    ];
  }

  List<DataRow> _buildRows(BuildContext context) {
    return agents.asMap().entries.map((entry) {
      final index = entry.key;
      final agent = entry.value;
      final displayIndex = index + 1;
      final rowColor = displayIndex.isEven ? Colors.grey[300] : Colors.white;
      return DataRow(
        color: MaterialStateColor.resolveWith((_) => rowColor!),
        cells: [
          DataCell(Text(displayIndex.toString())),
          DataCell(Text(agent.nom)),
          DataCell(Text(agent.prenom)),
          DataCell(Text(agent.cin)),
          DataCell(Text(agent.tel)),
          DataCell(
              Visibility(visible: false, child: Text(agent.id.toString()))),
        ],
        onLongPress: () => _handleLongPress(context, agent, index),
      );
    }).toList();
  }

  void _handleLongPress(BuildContext context, Agent agent, int index) {
    if (controller != null) {
      showDialog(
        context: context,
        builder: (_) => AgentDetailsDialog(
          agent: agent,
          controller: controller,
          agentIndex: index,
        ),
      );
    }
  }
}
