import 'package:flutter/material.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../secrets.dart';
import '../../domain/service_entity.dart';

Widget serviceBox(BuildContext context, Service service) {
  //print(service.imagenes);
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed('/service/details', arguments: service);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 250,
      child: Column(
        children: [
          _serviceImage(service.imagenes),
          Text(
            service.titulo,
            style: titleLable,
          ),
          (service.categorias.isEmpty)
              ? Text("No hay categorias")
              : Text(
                  service.categorias.first.nombre,
                  style: labels,
                ),
          Divider(),
          Text(service.publicado.toIso8601String()),
        ],
      ),
    ),
  );
}

Widget _serviceImage(List<String> imagenes) {
  if (imagenes.isEmpty) {
    return Container(
      height: 150,
      color: Colors.grey,
    );
  } else {
    //print("https://${baseUrl}${imagenes.first}");
    return Image.network(
      "https://${baseUrl}${imagenes.first}",
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(Icons.error),
        );
      },
      height: 150,
    );
  }
}
