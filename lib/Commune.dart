import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'services/service_base.dart';
import 'services/service_widget.dart';

class CommuneList extends StatefulWidget {
  static String Route = "/commune";
  const CommuneList({super.key, required this.Communes});

  final List<Commune> Communes;

  @override
  State<CommuneList> createState() => _CommuneListState();
}

class _CommuneListState extends State<CommuneList> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: <DataColumn>[
              const DataColumn(label: Expanded(child: Text('ID'))),
              const DataColumn(label: Expanded(child: Text('Pachalik'))),
              const DataColumn(label: Expanded(child: Text('Caidat'))),
              const DataColumn(label: Expanded(child: Text('Nom'))),
              const DataColumn(label: Expanded(child: Text('Latitude'))),
              const DataColumn(label: Expanded(child: Text('Longitude'))),
              DataColumn(
                  label: Container(
                width: 0,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
              )),
            ],
            rows: widget.Communes.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final commune = entry.value;
              final rowColor = index.isEven ? Colors.grey[300] : Colors.white;
              return DataRow(
                  color: MaterialStateColor.resolveWith((states) => rowColor!),
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(commune.pachalikcircon)),
                    DataCell(Text(commune.caidat)),
                    DataCell(Text(commune.nom)),
                    DataCell(Text(commune.latitude.toString())),
                    DataCell(Text(commune.longitude.toString())),
                    DataCell(Visibility(
                        visible: false, child: Text(commune.id.toString()))),
                  ],
                  onLongPress: () => {showData(commune.id!, context)});
            }).toList(),
          ),
        ),
      )
    ]);
  }

  performCommuneUpdate(int index, Commune commune) async {
    String result = await ServiceBase.update(index, commune);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green[400],
    ));
  }

  _performCommuneDelete(int index, Commune commune) async {
    String result = await ServiceBase.delete(index, commune);
  }

  showData(int index, BuildContext context) async {
    Commune commune = (await ServiceBase.getData<Commune>(
        index, (jsonData) => Commune.fromJson(jsonData)));
    if (!context.mounted || commune == null) {
      return Error();
    }
    // here i m preparing attributes for the function in frontEnd file (it needs 3 lists
    List<String> fieldValuesIndicated = [
      'Pachalik: ${commune.pachalikcircon}',
      'Caidat: ${commune.caidat}',
      'Nom: ${commune.nom}',
      'Latitude: ${commune.latitude}',
      'Longitude: ${commune.longitude}'
    ];
    List<String> fieldValues = [
      (commune.pachalikcircon),
      (commune.caidat),
      (commune.nom),
      (commune.latitude.toString()),
      (commune.longitude.toString()),
    ];

    List<IconData> fieldIcons = [
      Icons.person,
      Icons.person,
      Icons.person,
      Icons.person,
      Icons.person,
    ];

    List<Color> fieldColors = [
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
    ];
    List<Widget> textFields = Design.buildTextFieldsEdit(
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
                          Text('Commune a supprimé:'),
                          SizedBox(height: 8),
                          Text('Pachalik: ${commune.pachalikcircon}'),
                          Text('Caidat: ${commune.caidat}'),
                          Text('Nom: ${commune.nom}'),
                          Text('Latitude: ${commune.latitude}'),
                          Text('Longitude: ${commune.longitude}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform action on confirmation
                            Navigator.of(context).pop(); // Close the dialog
                            _performCommuneDelete(index,
                                commune); // Call your deleteCommune function
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
              List<Object> result = Design.buildTextFieldsUpdate(
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
                          Commune newCommune = Commune(
                              pachalikcircon: controllers[0].text,
                              caidat: controllers[1].text,
                              nom: controllers[2].text,
                              latitude: double.parse(controllers[3].text),
                              longitude: double.parse(controllers[4].text));
                          performCommuneUpdate(index, newCommune);
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

class CommuneView extends StatelessWidget {
  static String Route = "/commune/create";
  const CommuneView({super.key});

  static const String _title = 'Ajouter une Commune';

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
  late String pachalikcircon = '';
  late String caidat = '';
  late String nom = '';
  late double latitude = 0;
  late double longitude = 0;

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
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: screenSize.width * 0.9,
                          height: screenSize.height * 0.1,
                          child: TextFormField(
                            decoration: Design.buildInputDecoration(
                                "Entrer Le pachalik circon",
                                Icons.person,
                                Colors.blue),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "SVP entrer Le pachalik circon";
                              }
                              pachalikcircon =
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
                          decoration: Design.buildInputDecoration(
                              "Entrer le Caïdat", Icons.person, Colors.blue),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "SVP entrer Le Caïdat";
                            }
                            caidat =
                                value; // Assign the entered value to the specified field
                            return null; // Return null when validation is successful
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: screenSize.height * 0.1,
                        child: TextFormField(
                          decoration: Design.buildInputDecoration(
                              "Entrer le Nom", Icons.person, Colors.blue),
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
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: screenSize.height * 0.1,
                        child: TextFormField(
                          //Design.buildTextFormFieldWithArgs(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[-0-9.]+$'))
                          ],
                          decoration: Design.buildInputDecoration(
                              "Entrer la latitude", Icons.person, Colors.blue),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "SVP entrer La latitude";
                            }
                            latitude = double.tryParse(value)!;
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                          width: screenSize.width * 0.9,
                          height: screenSize.height * 0.1,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[-0-9.]+$')),
                            ],
                            decoration: Design.buildInputDecoration(
                                "Entrer la longitude",
                                Icons.person,
                                Colors.blue),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "SVP entrer La longitude";
                              }
                              longitude = double.tryParse(value)!;
                              return null;
                            },
                          )),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Commune commune = Commune(
                                pachalikcircon: pachalikcircon,
                                caidat: caidat,
                                nom: nom,
                                latitude: latitude,
                                longitude: longitude);
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
                                        const Text('Commune Details:'),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Pachalik: ${commune.pachalikcircon}'),
                                        Text('Caidat: ${commune.caidat}'),
                                        Text('Nom: ${commune.nom}'),
                                        Text('Latitude: ${commune.latitude}'),
                                        Text('Longitude: ${commune.longitude}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Perform action on confirmation
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          _performCommuneCreation(
                                              commune); // Call your createCommune function
                                        },
                                        child: const Text('Confirm'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text('Cancel'),
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
                        label: const Text('Ajouter'),
                      )
                    ]))));
  }

  _performCommuneCreation(Commune commune) async {
    String result = await ServiceBase.create(commune);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
