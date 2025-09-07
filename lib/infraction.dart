import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'services/ui_service.dart';
import 'services/data_repository.dart';
import 'package:collection/collection.dart';

class InfractionList extends StatefulWidget {
  static String Route = "/infraction";
  const InfractionList({super.key, required this.Infractions});

  final List<Infraction> Infractions;

  @override
  State<InfractionList> createState() => _InfractionListState();
}

class _InfractionListState extends State<InfractionList> {
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
              const DataColumn(label: Expanded(child: Text('Nom'))),
              const DataColumn(label: Expanded(child: Text('Date'))),
              const DataColumn(label: Expanded(child: Text('Adresse'))),
              const DataColumn(label: Expanded(child: Text('Commune'))),
              const DataColumn(label: Expanded(child: Text('Violant'))),
              const DataColumn(label: Expanded(child: Text('Agent'))),
              const DataColumn(label: Expanded(child: Text('Categorie'))),
              const DataColumn(label: Expanded(child: Text('Latitude'))),
              const DataColumn(label: Expanded(child: Text('Longitude'))),
              DataColumn(
                  label: Container(
                width: 0,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
              )),
            ],
            rows: widget.Infractions.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final infraction = entry.value;
              final rowColor = index.isEven ? Colors.grey[300] : Colors.white;
              return DataRow(
                  color: MaterialStateColor.resolveWith((states) => rowColor!),
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(infraction.nom)),
                    DataCell(Text(infraction.date)),
                    DataCell(Text(infraction.adresse)),
                    DataCell(Text(infraction.commune_id.toString())),
                    DataCell(Text(infraction.violant_id.toString())),
                    DataCell(Text(infraction.agent_id.toString())),
                    DataCell(Text(infraction.categorie_id.toString())),
                    DataCell(Text(infraction.latitude.toString())),
                    DataCell(Text(infraction.longitude.toString())),
                    DataCell(Visibility(
                        visible: false, child: Text(infraction.id.toString()))),
                  ],
                  onLongPress: () => {showData(infraction.id!, context)});
            }).toList(),
          ),
        ),
      )
    ]);
  }

  performInfractionUpdate(int index, Infraction infraction) async {
    String result = await UiService.performInfractionUpdate(index, infraction);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green[400],
    ));
  }

  _performInfractionDelete(int index, Infraction infraction) async {
    String result = await UiService.performInfractionDelete(index, infraction);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          result.contains('Error') ? Colors.red[400] : Colors.green[400],
    ));
  }

  showData(int index, BuildContext context) async {
    Infraction infraction = await DataRepository.getInfraction(index);
    if (!context.mounted) {
      return;
    }
    // here i m preparing attributes for the function in frontEnd file (it needs 3 lists)
    //Indicated means that i am going to show in longpress of Datatable
    List<String> fieldValuesIndicated = [
      'Nom: ${infraction.nom}',
      'Date: ${infraction.date}',
      'Adresse: ${infraction.adresse}',
      'Commune: ${infraction.commune_id}',
      'Violant: ${infraction.violant_id}',
      'Agent: ${infraction.agent_id}',
      'Catégorie: ${infraction.categorie_id}',
      'Latitude: ${infraction.latitude}',
      'Longitude: ${infraction.longitude}'
    ];
    // here i didnt do Nom And Date bcs i want to customize Date (Datepicker)
    List<String> fieldValues = [
      (infraction.adresse),
      (infraction.commune_id.toString()),
      (infraction.violant_id.toString()),
      (infraction.agent_id.toString()),
      (infraction.categorie_id.toString()),
      (infraction.latitude.toString()),
      (infraction.longitude.toString()),
    ];

    List<IconData> fieldIconsIndicated = [
      Icons.perm_contact_cal,
      Icons.date_range,
      Icons.location_on_outlined,
      Icons.location_city_outlined,
      Icons.perm_identity,
      Icons.badge,
      Icons.category_outlined,
      Icons.gps_fixed_outlined,
      Icons.gps_fixed_outlined,
    ];
    List<IconData> fieldIcons = [
      Icons.location_on_outlined,
      Icons.location_city_outlined,
      Icons.perm_identity,
      Icons.badge,
      Icons.category_outlined,
      Icons.gps_fixed_outlined,
      Icons.gps_fixed_outlined,
    ];
    List<Color> fieldColorsIndicated = [
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
    ];
    List<Color> fieldColors = [
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
    ];
    TextEditingController nomInput = TextEditingController();
    TextEditingController dateInput = TextEditingController();
    nomInput.text = infraction.nom;
    dateInput.text = infraction.date;
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
                          Text('Infraction a supprimé:'),
                          SizedBox(height: 8),
                          Text('Nom: ${infraction.nom}'),
                          Text('Latitude: ${infraction.latitude}'),
                          Text('Longitude: ${infraction.longitude}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform action on confirmation
                            Navigator.of(context).pop(); // Close the dialog
                            _performInfractionDelete(index,
                                infraction); // Call your deleteInfraction function
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
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nomInput,
                      decoration: UiService.buildShowDecoration(infraction.nom,
                          Icons.perm_contact_cal_outlined, Colors.blue),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: dateInput,
                      readOnly: true,
                      decoration: UiService.buildShowDecoration(
                          infraction.date, Icons.date_range, Colors.blue),
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
                  ],
                ),
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
                          Infraction newInfraction = Infraction(
                            nom: nomInput.text,
                            date: dateInput.text,
                            adresse: controllers[0].text,
                            commune_id: int.parse(controllers[1].text),
                            violant_id: int.parse(controllers[2].text),
                            agent_id: int.parse(controllers[3].text),
                            categorie_id: int.parse(controllers[4].text),
                            latitude: double.parse(controllers[3].text),
                            longitude: double.parse(controllers[4].text),
                          );
                          performInfractionUpdate(index, newInfraction);
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

class InfractionView extends StatefulWidget {
  static String Route = "/infraction/create";
  InfractionView(
      {super.key,
      required this.Communes,
      required this.Violants,
      required this.Agents,
      required this.Categories});
  final List<Commune> Communes;
  final List<Violant> Violants;
  final List<Agent> Agents;
  final List<Categorie> Categories;
  static const String _title = 'Ajouter une Infraction';
  @override
  State<InfractionView> createState() => _InfractionViewState();
}

class _InfractionViewState extends State<InfractionView> {
  final GlobalKey<_MyStatefulWidgetState> _Key =
      GlobalKey<_MyStatefulWidgetState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(InfractionView._title),
        actions: [
          IconButton(
              onPressed: () {
                _Key.currentState?.ValidateForm();
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: MyStatefulWidget(
          key: _Key,
          Communes: widget.Communes,
          Violants: widget.Violants,
          Agents: widget.Agents,
          Categories: widget.Categories),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget(
      {super.key,
      required this.Communes,
      required this.Violants,
      required this.Agents,
      required this.Categories});
  final List<Commune> Communes;
  final List<Violant> Violants;
  final List<Agent> Agents;
  final List<Categorie> Categories;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController dateInput = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String nom;
  late String date;
  late String adresse;
  late int commune_id = 0;
  late int violant_id = 0;
  late int agent_id = 0;
  late int categorie_id = 0;
  late double latitude;
  late double longitude;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: screenSize.width * 0.9,
                      height: screenSize.height * 0.1,
                      child: TextFormField(
                        decoration: UiService.buildInputDecoration(
                            "Entrer Le Nom",
                            Icons.perm_contact_cal_outlined,
                            Colors.blue),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "SVP Entrer Le Nom ";
                          }
                          nom =
                              value; // Assign the entered value to the specified field
                          return null; // Return null when validation is successful
                        },
                      ),
                    ),
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
                            "Entrer La Date", Icons.date_range, Colors.blue),
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
                              dateInput.text = DateFormat('yyyy-MM-dd').format(
                                  selectedDate); // Assign the selected date value to the specified field
                              date = dateInput.text;
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
                      keyboardType: TextInputType.streetAddress,
                      decoration: UiService.buildInputDecoration(
                          "Entrer l'adresse:  ",
                          Icons.location_on_outlined,
                          Colors.blue),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "SVP entrer une adresse";
                        }
                        adresse =
                            value; // Assign the entered value to the specified field
                        return null; // Return null when validation is successful
                      },
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.9,
                    height: screenSize.height * 0.1,
                    child: // DropdownButton for selecting Commune
                        DropdownButtonFormField<Commune>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        filled: true,
                        fillColor: Colors.blue[50],
                        labelText: 'Commune',
                      ),
                      value: commune_id != 0
                          ? widget.Communes.firstWhereOrNull(
                              (commune) => commune.id == commune_id)
                          : null,
                      onChanged: (Commune? newValue) {
                        if (newValue != null) {
                          setState(() {
                            commune_id = newValue.id!;
                          });
                        }
                      },
                      items: widget.Communes.map<DropdownMenuItem<Commune>>(
                          (Commune commune) {
                        return DropdownMenuItem<Commune>(
                          value: commune,
                          child: Text(commune.nom),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.9,
                    height: screenSize.height * 0.1,
                    child: DropdownButtonFormField<Violant>(
                      menuMaxHeight: screenSize.height * 0.3,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        labelText: 'Violent',
                        filled: true,
                        fillColor: Colors.blue[50],
                      ),
                      value: violant_id != 0
                          ? widget.Violants.firstWhereOrNull(
                              (violant) => violant.id == violant_id)
                          : null,
                      onChanged: (Violant? newValue) {
                        if (newValue != null) {
                          setState(() {
                            violant_id = newValue.id!;
                          });
                        }
                      },
                      items: widget.Violants.map<DropdownMenuItem<Violant>>(
                        (Violant violant) {
                          return DropdownMenuItem<Violant>(
                            value: violant,
                            child: Text("${violant.nom} ${violant.prenom}"),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.9,
                    height: screenSize.height * 0.1,
                    child: DropdownButtonFormField<Agent>(
                      menuMaxHeight: screenSize.height * 0.3,
                      decoration: InputDecoration(
                        labelText: 'Agent',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        filled: true,
                        fillColor: Colors.blue[50],
                      ),
                      value: agent_id != 0
                          ? widget.Agents.firstWhereOrNull(
                              (agent) => agent.id == agent_id)
                          : null,
                      onChanged: (Agent? newValue) {
                        if (newValue != null) {
                          setState(() {
                            agent_id = newValue.id!;
                          });
                        }
                      },
                      items: widget.Agents.map<DropdownMenuItem<Agent>>(
                        (Agent agent) {
                          return DropdownMenuItem<Agent>(
                            value: agent,
                            child: Text("${agent.nom} ${agent.prenom}"),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.9,
                    height: screenSize.height * 0.1,
                    child: DropdownButtonFormField<Categorie>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        filled: true,
                        fillColor: Colors.blue[50],
                        labelText: 'Categorie',
                      ),
                      value: categorie_id != 0
                          ? widget.Categories.firstWhereOrNull(
                              (categorie) => categorie.id == categorie_id)
                          : null,
                      onChanged: (Categorie? newValue) {
                        if (newValue != null) {
                          setState(() {
                            categorie_id = newValue.id!;
                          });
                        }
                      },
                      items: widget.Categories.map<DropdownMenuItem<Categorie>>(
                          (Categorie categorie) {
                        return DropdownMenuItem<Categorie>(
                          value: categorie,
                          child: Text(categorie.nom),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.9,
                    height: screenSize.height * 0.1,
                    child: TextFormField(
                      //UiService.buildTextFormFieldWithArgs(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^[-0-9.]+$'))
                      ],
                      decoration: UiService.buildInputDecoration(
                          "Entrer la latitude",
                          Icons.gps_fixed_outlined,
                          Colors.blue),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "SVP entrer La latitude";
                        }
                        latitude = double.parse(value);
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
                        decoration: UiService.buildInputDecoration(
                            "Entrer la longitude",
                            Icons.gps_fixed_outlined,
                            Colors.blue),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "SVP entrer La longitude";
                          }
                          longitude = double.parse(value);
                          return null;
                        },
                      )),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                ])));
  }

  _performInfractionCreation(Infraction infraction) async {
    String result = await UiService.performInfractionCreate(infraction);
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

  void ValidateForm() {
    if (_formKey.currentState!.validate()) {
      Infraction infraction = Infraction(
          nom: nom,
          date: date,
          adresse: adresse,
          commune_id: commune_id,
          violant_id: violant_id,
          agent_id: agent_id,
          categorie_id: categorie_id,
          latitude: latitude,
          longitude: longitude);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Infraction Details:'),
                  const SizedBox(height: 8),
                  Text('Nom: ${infraction.nom}'),
                  Text('Date: ${infraction.date}'),
                  Text('Adresse: ${infraction.adresse}'),
                  Text('Commune: ${infraction.commune_id}'),
                  Text('Violant: ${infraction.violant_id}'),
                  Text('Agent: ${infraction.agent_id}'),
                  Text('Catégorie: ${infraction.categorie_id}'),
                  Text('Latitude: ${infraction.latitude}'),
                  Text('Longitude: ${infraction.longitude}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Perform action on confirmation
                    Navigator.of(context).pop(); // Close the dialog
                    _performInfractionCreation(
                        infraction); // Call your createInfraction function
                  },
                  child: const Text('Confirm'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          });
    }
  }

  Future<List<dynamic>> buildList(String title) async {
    final List<Commune> communes = await UiService.buildCommuneList();
    return communes;
  }
}
