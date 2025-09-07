import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'services/ui_service.dart';
import 'services/data_repository.dart';

class AgentList extends StatefulWidget {
  static String Route = "/agent";
  const AgentList({super.key, required this.Agents});
  final List<Agent> Agents;
  @override
  State<AgentList> createState() => _AgentListState();
}

class _AgentListState extends State<AgentList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(label: Expanded(child: Text('ID'))),
            const DataColumn(label: Expanded(child: Text('Nom'))),
            const DataColumn(label: Expanded(child: Text('Prénom'))),
            const DataColumn(label: Expanded(child: Text('CIN'))),
            const DataColumn(label: Expanded(child: Text('N.Téle'))),
            DataColumn(
                label: Container(
              width: 0,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
            )),
          ],
          rows: widget.Agents.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final agent = entry.value;
            final rowColor = index.isEven ? Colors.grey[300] : Colors.white;
            return DataRow(
                color: MaterialStateColor.resolveWith((states) => rowColor!),
                cells: [
                  DataCell(Text(index.toString())),
                  DataCell(Text(agent.nom)),
                  DataCell(Text(agent.prenom)),
                  DataCell(Text(agent.cin)),
                  DataCell(Text(agent.tel)),
                  DataCell(Visibility(
                      visible: false, child: Text(agent.id.toString()))),
                ],
                onLongPress: () => {showData(agent.id!, context)});
          }).toList(),
        ),
      ),
    );
  }

  performAgentUpdate(int index, Agent agent) async {
    String result = await UiService.performAgentUpdate(index, agent);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green[400],
    ));
  }

  _performAgentDelete(int index, Agent agent) async {
    String result = await UiService.performAgentDelete(index, agent);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          result.contains('Error') ? Colors.red[400] : Colors.green[400],
    ));
  }

  showData(int index, BuildContext context) async {
    Agent agent = await DataRepository.getAgent(index);
    if (!context.mounted) {
      return;
    }
    // here i m preparing attributes for the function in frontEnd file (it needs 3 lists
    List<String> fieldValuesIndicated = [
      'Nom: ${agent.nom}',
      'Prénom: ${agent.prenom}',
      'CIN: ${agent.cin}',
      'N°Tele: ${agent.tel}'
    ];
    List<String> fieldValues = [
      (agent.nom),
      (agent.prenom),
      (agent.cin),
      (agent.tel)
    ];

    List<IconData> fieldIcons = [
      Icons.perm_contact_cal,
      Icons.perm_contact_cal_outlined,
      Icons.credit_card,
      Icons.phone,
    ];

    List<Color> fieldColors = [
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue
    ];

    List<Widget> textFields = UiService.buildTextFieldsEdit(
        fieldValuesIndicated, fieldIcons, fieldColors, context);
    List<Widget> AllWidget = [
      ...textFields,
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.03,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            icon: Icon(Icons.delete_forever_outlined),
            label: Text('Supprimer'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Agent a supprimé:'),
                          SizedBox(height: 8),
                          Text('Nom: ${agent.nom}'),
                          Text('Prenom: ${agent.prenom}'),
                          Text('CIN: ${agent.cin}'),
                          Text('N°Téle: ${agent.tel}')
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform action on confirmation
                            Navigator.of(context).pop(); // Close the dialog
                            _performAgentDelete(index, agent);
                            // Call your deleteAgent function
                            Navigator.of(context).pop();
                          },
                          child: Text('Confirmer'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Annuler'),
                        ),
                      ],
                    );
                  });
            }),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 2.5, horizontal: 21.0),
                backgroundColor: Colors.orange[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            icon: Icon(Icons.edit_outlined),
            label: Text('Modifier'),
            onPressed: () {
              List<Object> result = UiService.buildTextFieldsUpdate(
                  fieldValues, fieldIcons, fieldColors, context);
              List<TextEditingController> controllers =
                  result[1] as List<TextEditingController>;
              List<Widget> inputFields = result[0] as List<Widget>;
              List<Widget> AllWidgetUpdate = [
                ...inputFields,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        icon: const Icon(Icons.cancel),
                        label: const Text('Annuler'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.orange[300],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: const Text('Enregistrer'),
                        onPressed: () {
                          Agent newAgent = Agent(
                              nom: controllers[0].text,
                              prenom: controllers[1].text,
                              cin: controllers[2].text,
                              tel: controllers[3].text);
                          performAgentUpdate(index, newAgent);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }),
                  ],
                )
              ];
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Dialog.fullscreen(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: AllWidgetUpdate,
                            ),
                          ),
                        ),
                      ));
                },
              );
            })
      ])
    ];

// Use the generated textFields list in your widget tree
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Dialog.fullscreen(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: AllWidget,
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class AgentView extends StatelessWidget {
  static String Route = "/agent/create";
  const AgentView({super.key});

  static const String _title = 'Ajouter un Agent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String nom = '';
  late String prenom = '';
  late String tel = '';
  late String cin = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: screenSize.width * 0.9,
                          height: screenSize.height * 0.1,
                          child: TextFormField(
                            decoration: UiService.buildInputDecoration(
                                "Entrer Le Nom d'Agent",
                                Icons.perm_contact_cal,
                                Colors.blue),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "SVP entrer Le Nom";
                              }
                              nom =
                                  value; // Assign the entered value to the specified field
                              return null; // Return null when validation is successful
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: screenSize.height * 0.1,
                        child: TextFormField(
                          decoration: UiService.buildInputDecoration(
                              "Entrer le Prénom d'Agent",
                              Icons.perm_contact_cal_outlined,
                              Colors.blue),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "SVP entrer Le Prénom";
                            }
                            prenom =
                                value; // Assign the entered value to the specified field
                            return null; // Return null when validation is successful
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: screenSize.height * 0.1,
                        child: TextFormField(
                          decoration: UiService.buildInputDecoration(
                              "Entrer le CIN d'Agent",
                              Icons.credit_card,
                              Colors.blue),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "SVP entrer Le CIN";
                            }
                            if (value.length > 12) {
                              return "Le CIN ne doit pas dépasser 12 caractères";
                            }
                            if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
                              return "Le CIN ne doit contenir que des lettres majuscules et des chiffres";
                            }
                            cin =
                                value; // Assign the entered value to the specified field
                            return null; // Return null when validation is successful
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: screenSize.height * 0.1,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: UiService.buildInputDecoration(
                              "Entrer le N°Téle d'Agent",
                              Icons.phone,
                              Colors.blue),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "SVP entrer Le N°Téle";
                            }
                            if (value.length != 10) {
                              return "Le numéro doit contenir exactement 10 chiffres";
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return "Le numéro ne doit contenir que des chiffres";
                            }
                            tel =
                                value; // Assign the entered value to the specified field
                            return null; // Return null when validation is successful
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Agent agent = Agent(
                                nom: nom, prenom: prenom, tel: tel, cin: cin);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmation'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Agent Details:'),
                                        SizedBox(height: 8),
                                        Text('Nom: ${agent.nom}'),
                                        Text('Prenom: ${agent.prenom}'),
                                        Text('Tel: ${agent.tel}'),
                                        Text('CIN: ${agent.cin}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Perform action on confirmation
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          _performAgentCreation(
                                              agent); // Call your createAgent function
                                        },
                                        child: Text('Confirm'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                              screenSize.width * 0.4, screenSize.height * 0.05),
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        icon: Icon(Icons.person_add),
                        label: Text('Ajouter'),
                      )
                    ]))));
  }

  _performAgentCreation(Agent agent) async {
    String result = await UiService.performAgentCreate(agent);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          result.contains('Error') ? Colors.red[400] : Colors.green[400],
    ));
  }
}
