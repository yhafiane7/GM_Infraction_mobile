import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'services/ui_service.dart';
import 'services/data_repository.dart';

class ViolantList extends StatefulWidget {
  static String Route = "/violant";
  const ViolantList({super.key, required this.Violants});
  final List<Violant> Violants;
  @override
  State<ViolantList> createState() => _ViolantListState();
}

class _ViolantListState extends State<ViolantList> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            sortColumnIndex: 0,
            columns: <DataColumn>[
              const DataColumn(
                  numeric: true, label: Expanded(child: Text('ID'))),
              const DataColumn(label: Expanded(child: Text('Nom'))),
              const DataColumn(label: Expanded(child: Text('Prénom'))),
              const DataColumn(label: Expanded(child: Text('CIN'))),
              DataColumn(
                  label: Container(
                width: 0,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
              )),
            ],
            rows: widget.Violants.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final violant = entry.value;
              final rowColor = index.isEven ? Colors.grey[300] : Colors.white;
              return DataRow(
                  color: MaterialStateColor.resolveWith((states) => rowColor!),
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(violant.nom)),
                    DataCell(Text(violant.prenom)),
                    DataCell(Text(violant.cin)),
                    DataCell(Visibility(
                        visible: false, child: Text(violant.id.toString()))),
                  ],
                  onLongPress: () => {showData(violant.id!, context)});
            }).toList(),
          ),
        ),
      )
    ]);
  }

  performViolantUpdate(int index, Violant violant) async {
    String result = await UiService.performViolantUpdate(index, violant);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green[400],
    ));
  }

  _performViolantDelete(int index, Violant violant) async {
    String result = await UiService.performViolantDelete(index, violant);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          result.contains('Error') ? Colors.red[400] : Colors.green[400],
    ));
  }

  showData(int index, BuildContext context) async {
    Violant violant = await DataRepository.getViolant(index);
    if (!context.mounted) {
      return;
    }
    // here i m preparing attributes for the function in frontEnd file (it needs 3 lists
    List<String> fieldValuesIndicated = [
      'Nom: ${violant.nom}',
      'Prénom: ${violant.prenom}',
      'CIN: ${violant.cin}',
    ];
    List<String> fieldValues = [
      (violant.nom),
      (violant.prenom),
      (violant.cin),
    ];
    List<IconData> fieldIcons = [
      Icons.person,
      Icons.person,
      Icons.person,
    ];

    List<Color> fieldColors = [
      Colors.blue,
      Colors.blue,
      Colors.blue,
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
                          Text('Violant a supprimé:'),
                          SizedBox(height: 8),
                          Text('Nom: ${violant.nom}'),
                          Text('Prenom: ${violant.prenom}'),
                          Text('CIN: ${violant.cin}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform action on confirmation
                            Navigator.of(context).pop(); // Close the dialog
                            _performViolantDelete(index,
                                violant); // Call your deleteAgent function
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
                backgroundColor: Colors.orange[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            icon: Icon(Icons.edit_outlined),
            label: Text('modifier'),
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
                          Violant newViolant = Violant(
                              nom: controllers[0].text,
                              prenom: controllers[1].text,
                              cin: controllers[2].text);
                          performViolantUpdate(index, newViolant);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }),
                  ],
                )
              ];
              showDialog(
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
            padding: EdgeInsets.all(20),
            child: Dialog.fullscreen(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: AllWidget,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ViolantView extends StatelessWidget {
  static String Route = "/violant/create";
  const ViolantView({super.key});

  static const String _title = 'Ajouter un Violant';

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
                                "Entrer Le Nom du Violant",
                                Icons.person,
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
                              "Entrer le Prénom du Violant",
                              Icons.person,
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
                              "Entrer le CIN du Violant",
                              Icons.person,
                              Colors.blue),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "SVP entrer Le CIN";
                            }
                            cin =
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
                            Violant violant =
                                Violant(nom: nom, prenom: prenom, cin: cin);
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmation'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Violant Details:'),
                                        SizedBox(height: 8),
                                        Text('Nom: ${violant.nom}'),
                                        Text('Prenom: ${violant.prenom}'),
                                        Text('CIN: ${violant.cin}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Perform action on confirmation
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          _performViolantCreation(
                                              violant); // Call your createViolant function
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

  _performViolantCreation(Violant violant) async {
    String result = await UiService.performViolantCreate(violant);
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
  }
}
