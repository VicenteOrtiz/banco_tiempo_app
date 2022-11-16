import 'package:banco_tiempo_app/cross_features/public_profile/domain/public_profile.dart';
import 'package:banco_tiempo_app/secrets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/presentation/app_theme.dart';

String url = "https://$baseUrl";

Widget AttributeList(List<Cualidad> cualidades) {
  return Column(
    children: [
      Text("Cualidades",
          style: titleLable.copyWith(
            color: ColorPrimary.primaryColor,
            fontSize: 25,
          )),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: cualidades
              .map(
                (e) => Attribute(e),
              )
              .toList(),
        ),
      ),
    ],
  );
}

Widget Attribute(Cualidad cualidad) {
  print("$url${cualidad.imagenUrl}");
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        SvgPicture.network("$url${cualidad.imagenUrl}",
            semanticsLabel: 'A shark?!',
            width: 50,
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator())),
        verticalSpace10,
        Text(
          cualidad.nombre,
          style: labels,
        ),
      ],
    ),
  );
}