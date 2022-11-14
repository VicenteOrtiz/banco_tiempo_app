import 'package:flutter/material.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../infraestructure/models/pending_services_dto.dart';

class ServiceListItem extends StatelessWidget {
  final RequestedServiceDto requestedService;
  const ServiceListItem({
    required this.requestedService,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 24,
        child: Icon(
          Icons.handshake,
          color: ColorPrimary.primaryColor,
        ),
      ),
      title: Text(
        requestedService.servicio.titulo,
        style: appTextTheme.bodyText2,
      ),
      subtitle: Text(
        _statusText(requestedService),
        style: labels,
      ),
      trailing: Text(
        '${requestedService.servicio.horas} bono',
        style:
            appTextTheme.subtitle1?.copyWith(color: ColorPrimary.primaryColor),
      ),
    );
  }
}

String _statusText(RequestedServiceDto service) {
  if (service.aceptado) {
    return "Confirmado";
  } else if (service.cancelado) {
    return "Cancelado";
  } else {
    return "Pendiente";
  }
}