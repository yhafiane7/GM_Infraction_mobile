import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';
import 'services/ui_service.dart';
import 'services/data_repository.dart';

class CategorieList extends StatefulWidget {
  static String Route = "/categorie";
  const CategorieList({super.key, required this.Categories});

  final List<Categorie> Categories;

  @override
  State<CategorieList> createState() => _CategorieListState();
}

class _CategorieListState extends State<CategorieList> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                  label: Container(
                child: Text('ID'),
                width: MediaQuery.of(context).size.width * 0.1,
              )),
              DataColumn(
                  label: Container(
                child: Text('Nom'),
                width: MediaQuery.of(context).size.width * 0.2,
              )),
              DataColumn(
                  label: Container(
                child: Text('Degre'),
                width: MediaQuery.of(context).size.width * 0.2,
              )),
              DataColumn(
                  label: Container(
                width: 0,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
              )),
            ],
            rows: widget.Categories.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final categorie = entry.value;
              final rowColor = index.isEven ? Colors.grey[300] : Colors.white;
              return DataRow(
                  color: MaterialStateColor.resolveWith((states) => rowColor!),
                  cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text(categorie.nom)),
                    DataCell(Text(categorie.degre.toString())),
                    DataCell(Visibility(
                        visible: false, child: Text(categorie.id.toString()))),
                  ],
                  onLongPress: () => {showData(categorie.id!, context)});
            }).toList(),
          ),
        ),
      )
    ]);
  }

  performCategorieUpdate(int index, Categorie categorie) async {
    String result = await UiService.performCategorieUpdate(index, categorie);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green[400],
    ));
  }

  _performCategorieDelete(int index, Categorie categorie) async {
    String result = await UiService.performCategorieDelete(index, categorie);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          result.contains('Error') ? Colors.red[400] : Colors.green[400],
    ));
  }

  showData(int index, BuildContext context) async {
    Categorie categorie = await DataRepository.getCategorie(index);
    if (!context.mounted) {
      return;
    }
    // here i m preparing attributes for the function in frontEnd file (it needs 3 lists
    List<String> fieldValuesIndicated = [
      'Nom: ${categorie.nom}',
      'degree: ${categorie.degre.toString()}'
    ];
    List<String> fieldValues = [(categorie.nom), (categorie.degre.toString())];
    List<IconData> fieldIcons = [
      Icons.category_outlined,
      Icons.hdr_weak_sharp,
    ];

    List<Color> fieldColors = [
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
                          Text('Categorie a supprimé:'),
                          SizedBox(height: 8),
                          Text('Nom: ${categorie.nom}'),
                          Text('degré: ${categorie.degre}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform action on confirmation
                            Navigator.of(context).pop(); // Close the dialog
                            _performCategorieDelete(index,
                                categorie); // Call your deleteCategorie function
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
                          Categorie newCategorie = Categorie(
                              nom: controllers[0].text,
                              degre: int.parse(controllers[1].text));
                          performCategorieUpdate(index, newCategorie);
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

class CategorieView extends StatelessWidget {
  static String Route = "/categorie/create";
  const CategorieView({super.key});

  static const String _title = 'Ajouter une Catégorie';

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
  late int degre = 0;

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
                                "Entrer Le Nom du Categorie",
                                Icons.category_outlined,
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: UiService.buildInputDecoration(
                              "Entrer la degree du Categorie",
                              Icons.hdr_weak_sharp,
                              Colors.blue),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "SVP entrer La degree";
                            }
                            degre = int.tryParse(
                                value)!; // Assign the entered value to the specified field
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
                            Categorie categorie =
                                Categorie(nom: nom, degre: degre);
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
                                        Text('Categorie Details:'),
                                        SizedBox(height: 8),
                                        Text('Nom: ${categorie.nom}'),
                                        Text('Degree: ${categorie.degre}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Perform action on confirmation
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          _performCategorieCreation(
                                              categorie); // Call your createCategorie function
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

  _performCategorieCreation(Categorie categorie) async {
    String result = await UiService.performCategorieCreate(categorie);
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
