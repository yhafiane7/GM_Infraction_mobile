import 'package:flutter/material.dart';
import 'package:gmsoft_infractions_mobile/models/button_option.dart';
import 'package:gmsoft_infractions_mobile/widgets/home_button.dart';

class DashboardView extends StatelessWidget {
  final List<ButtonOption> options;

  const DashboardView({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: options.length,
        itemBuilder: (context, index) {
          return HomeButton(buttonOption: options[index]);
        },
      ),
    );
  }
}
