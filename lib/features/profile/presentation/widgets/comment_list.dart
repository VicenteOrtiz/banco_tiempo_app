import 'package:flutter/material.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../cross_features/public_profile/infraestructure/models/public_profile_dto.dart';

Widget CommentList(List<Comentario> comentarios) {
  return Column(
    children: [
      Text(
        "Reseñas",
        style: titleLable.copyWith(
          color: ColorPrimary.primaryColor,
          fontSize: 25,
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: comentarios
              .map(
                (e) => Comment(e),
              )
              .toList(),
        ),
      ),
    ],
  );
}

Widget Comment(Comentario comentario) {
  return Card(
    elevation: 4,
    child: Container(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              comentario.comentario,
              style: labels,
            ),
            Divider(),
            Text(
              comentario.solicita.name + "" + comentario.solicita.lastName,
              style: titleLable,
            ),
          ],
        ),
      ),
    ),
  );
}
