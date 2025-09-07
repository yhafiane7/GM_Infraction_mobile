import 'package:flutter/material.dart';
import 'package:GM_INFRACTION/models/button_option.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key, required this.buttonOption}) : super(key: key);
  final ButtonOption buttonOption;

  static List<Widget> generateMenu(List<ButtonOption> options) {
    return options.map((option) => HomeButton(buttonOption: option)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Container(
      width: isSmallScreen ? screenSize.width * 0.4 : 200,
      height: isSmallScreen ? screenSize.height * 0.15 : 120,
      margin: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: buttonOption.route == null
              ? null
              : () {
                  Navigator.pushNamed(
                    context,
                    buttonOption.route!,
                    arguments: buttonOption.arguments,
                  );
                },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (buttonOption.iconData != null) ...[
                  Icon(
                    buttonOption.iconData,
                    size: isSmallScreen ? 32 : 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 8),
                ],
                Flexible(
                  child: Text(
                    buttonOption.text,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (buttonOption.subText != null) ...[
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      buttonOption.subText!,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
