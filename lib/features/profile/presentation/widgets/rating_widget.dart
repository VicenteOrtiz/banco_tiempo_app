import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:flutter/material.dart';

Widget RatingWidget(int rating) {
  return Column(
    children: [
      Text(
        "Calificación",
        style: titleLable.copyWith(
          color: ColorPrimary.primaryColor,
          fontSize: 25,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            rating.toString(),
            style: labels.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 255, 215, 0),
            size: 25,
          ),
        ],
      ),
    ],
  );
}
