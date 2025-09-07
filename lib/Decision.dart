import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:GM_INFRACTION/models/decision_model.dart';
import 'services/ui_service.dart';
import 'services/data_repository.dart';

class DecisionList extends StatefulWidget {
  static String Route = "/decision";
  const DecisionList({super.key, required this.Decisions});
  final List<Decision> Decisions;
  @override
  State<DecisionList> createState() => _DecisionListState();
}

class _DecisionListState extends State<DecisionList> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(label: Expanded(child: Text('ID'))),
              const DataColumn(label: Expanded(child: Text('Date'))),
              const DataColumn(label: Expanded(child: Text('Decision Prise'))),
              const DataColumn(label: Expanded(child: Text('N°Infraction'))),
              DataColumn(
                  label: Container(
                width: 0,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
              )),
            ],
            rows: widget.Decisions.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final decision = entry.value;
              final rowColor = index.isEven ? Colors.grey[300] : Colors.white;
              return DataRow(
                  color: MaterialStateColor.resolveWith((states) => rowColor!),
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(decision.date)),
                    DataCell(Text(decision.decisionPrise)),
                    DataCell(Text(decision.infractionId.toString())),
                    DataCell(Visibility(
                        visible: false, child: Text(decision.id.toString()))),
                  ],
                  onLongPress: () => {showData(decision.id!, context)});
            }).toList(),
          ),
        ),
      )
    ]);
  }

  performDecisionUpdate(int index, Decision decision) async {
    String result = await UiService.performDecisionUpdate(index, decision);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green[400],
    ));
  }

  _performDecisionDelete(int index, Decision decision) async {
    String result = await UiService.performDecisionDelete(index, decision);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          result.contains('Error') ? Colors.red[400] : Colors.green[400],
    ));
  }

  showData(int index, BuildContext context) async {
    Decision decision = await DataRepository.getDecision(index);
    if (!context.mounted) {
      return;
    }
    // here i m preparing attributes for the function in frontEnd file (it needs 3 lists
    List<String> fieldValuesIndicated = [
      'ID: ${decision.id}',
      'Decision: ${decision.decisionPrise}',
      'N°Infraction: ${decision.infractionId}',
      'Date: ${decision.date}',
    ];
    List<String> fieldValues = [
      (decision.decisionPrise.toString()),
      (decision.infractionId.toString()),
    ];

    List<IconData> fieldIconsIndicated = [
      Icons.person,
      Icons.person,
      Icons.person,
      Icons.person,
    ];
    List<IconData> fieldIcons = [
      Icons.person,
      Icons.person,
    ];

    List<Color> fieldColorsIndicated = [
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue
    ];
    List<Color> fieldColors = [Colors.blue, Colors.blue];
    TextEditingController dateInput =
        TextEditingController(); // for modifier function
    dateInput.text = decision.date;
    List<Widget> textFields = UiService.buildTextFieldsEdit(
        fieldValuesIndicated,
        fieldIconsIndicated,
        fieldColorsIndicated,
        context);
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
                          Text('Decision a supprimé:'),
                          SizedBox(height: 8),
                          Text('ID: ${decision.id}'),
                          Text('Date: ${decision.date}'),
                          Text('Decision: ${decision.decisionPrise}'),
                          Text('N°Infraction: ${decision.infractionId}')
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform action on confirmation
                            Navigator.of(context).pop(); // Close the dialog
                            _performDecisionDelete(index,
                                decision); // Call your deleteDecision function
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
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: dateInput,
                      readOnly: true,
                      decoration: UiService.buildInputDecoration(
                          decision.date, Icons.person, Colors.blue),
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
                            dateInput.text = DateFormat('yyyy-MM-dd').format(
                                selectedDate); // Assign the selected date value to the specified field
                          });
                        }
                      },
                    ),
                  ),
                ),
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
                          Decision newDecision = Decision(
                            decisionPrise: controllers[0].text,
                            infractionId: int.parse(controllers[1].text),
                            date: dateInput.text,
                          );
                          performDecisionUpdate(index, newDecision);
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
                      child: Dialog.fullscreen(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: AllWidgetUpdate,
                        ),
                      ),
                    ),
                  );
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
              padding: const EdgeInsets.all(20),
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

class DecisionView extends StatelessWidget {
  static String Route = "/decision/create";
  const DecisionView({super.key});

  static const String _title = 'Ajouter une Décision';

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
  TextEditingController dateInput = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String date = '';
  late String decisionPrise = '';
  late int infractionId = 0;

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
                            keyboardType: TextInputType.datetime,
                            controller: dateInput,
                            readOnly: true,
                            decoration: UiService.buildInputDecoration(
                                "Entrer La Date :", Icons.person, Colors.blue),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "SVP entrer La Date";
                              }
                              return null; // Return null when validation is successful
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
                                  dateInput.text = DateFormat('yyyy-MM-dd')
                                      .format(selectedDate);
                                  date = dateInput
                                      .text; // Assign the selected date value to the specified field
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: screenSize.height * 0.1,
                        child: TextFormField(
                          decoration: UiService.buildInputDecoration(
                              "Entrer la Decision", Icons.person, Colors.blue),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "SVP entrer La Decision";
                            }
                            decisionPrise =
                                value; // Assign the entered value to the specified field
                            return null; // Return null when validation is successful
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: screenSize.height * 0.1,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: UiService.buildInputDecoration(
                              "Entrer le Numero d'Infraction",
                              Icons.person,
                              Colors.blue),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "SVP Numero d'Infraction";
                            }
                            infractionId = int.parse(
                                value); // Assign the entered value to the specified field
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
                            Decision decision = Decision(
                              date: date,
                              decisionPrise: decisionPrise,
                              infractionId: infractionId,
                            );
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
                                        Text('Decision Details:'),
                                        SizedBox(height: 8),
                                        Text('Date: ${decision.date}'),
                                        Text(
                                            'Decision Prise: ${decision.decisionPrise}'),
                                        Text(
                                            'N°Infraction: ${decision.infractionId}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _performDecisionCreation(decision)
                                              .toString();
                                          // Perform action on confirmation
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          // Call your createDecision function
                                        },
                                        child: const Text('Confirmer'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text('Annuler'),
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

  _performDecisionCreation(Decision decision) async {
    String result = await UiService.performDecisionCreate(decision);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          result.contains('Error') ? Colors.red[400] : Colors.green[400],
    ));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
    ));
    return result;
  }
}
