import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'link_button.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    Key? key,
    required this.labelText,
    //required this.nextPage,
  }) : super(key: key);

  final String labelText;
  //final PageRouteInfo nextPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: LinkButton(
        label: labelText,
        iconRight: Icons.chevron_right,
        color: ColorPrimary.primaryColor,
        onPressed: () {
          //AutoRouter.of(context).push(nextPage);
          print("HIZO CLICK EN EL CUSTOMLABEL");
        },
      ),
    );
  }
}
