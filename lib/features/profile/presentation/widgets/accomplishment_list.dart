import 'package:banco_tiempo_app/cross_features/public_profile/domain/public_profile.dart';
import 'package:banco_tiempo_app/secrets.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/presentation/app_theme.dart';

String url = "https://$baseUrl";

Widget AccomplishmentList(List<Cualidad> cualidades) {
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
                (e) => Accomplishment(e),
              )
              .toList(),
        ),
      ),
    ],
  );
}

Widget Accomplishment(Cualidad cualidad) {
  print("$url${cualidad.imagenUrl}");
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        CachedNetworkImage(
          imageUrl: "$url${cualidad.imagenUrl}",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        verticalSpace10,
        Text(cualidad.nombre),
      ],
    ),
  );
}
