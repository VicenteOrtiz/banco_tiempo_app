import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:flutter/material.dart';

Future<dynamic> dialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: TextStyle(color: ColorPrimary.primaryColor),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Función en desarrollo"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Esta función estará disponible pronto."),
        /* Image.asset(
          'assets/images/.jpg',
        ), */
      ],
    ),
    actions: [
      okButton,
    ],
  );
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
