import 'package:flutter/material.dart';

class Design {
  static InputDecoration buildInputDecoration(
      String hintText, IconData icon, Color iconColor) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      prefixIcon: Icon(
        icon,
        color: iconColor,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.blue),
      filled: true,
      fillColor: Colors.blue[50],
    );
  }

  static InputDecoration buildShowDecoration(
      String hintText, IconData icon, Color iconColor) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      prefixIcon: Icon(
        icon,
        color: iconColor,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.blue),
      filled: true,
      fillColor: Colors.blue[50],
    );
  }

  static List<Widget> buildTextFieldsEdit(List<String> values,
      List<IconData> icons, List<Color> colors, BuildContext context) {
    assert(values.length == icons.length && values.length == colors.length);

    return List<Widget>.generate(values.length, (index) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          TextField(
            readOnly: true,
            decoration: Design.buildShowDecoration(
                values[index], icons[index], colors[index]),
          ),
        ],
      );
    });
  }

  static List<Object> buildTextFieldsUpdate(List<String> values,
      List<IconData> icons, List<Color> colors, BuildContext context) {
    assert(values.length == icons.length && values.length == colors.length);

    List<TextEditingController> controllers = List.generate(
        values.length, (index) => TextEditingController(text: values[index]));

    List<Widget> textFields = List<Widget>.generate(values.length, (index) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          TextFormField(
            controller: controllers[index],
            decoration: Design.buildShowDecoration(
                values[index], icons[index], colors[index]),
          ),
        ],
      );
    });
    return [textFields, controllers];
  }

  static showDialog(AllWidget,BuildContext context) {
     
      return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding:const EdgeInsets.all(20),
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
  }
}
