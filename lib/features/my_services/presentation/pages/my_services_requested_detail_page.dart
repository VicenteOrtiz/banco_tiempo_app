import '../../../../app/presentation/app_theme.dart';
import '../../../../cross_features/widgets/appbar_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../secrets.dart';
import '../../infraestructure/models/pending_services_dto.dart';
import '../bloc/my_services_bloc.dart';

class MyServicesRequestedDetailPage extends StatelessWidget {
  final RequestedServiceDto requestedService;
  const MyServicesRequestedDetailPage({
    required this.requestedService,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Servicio en Curso"),
        centerTitle: true,
      ),
      body: _serviceLayout(
          context, requestedService, context.read<MyServicesBloc>()),
    );
  }
}

Widget _serviceLayout(BuildContext context,
    RequestedServiceDto requestedService, MyServicesBloc bloc) {
  bool isPending = _isPending(requestedService);
  return BlocListener<MyServicesBloc, MyServicesState>(
    listener: (context, state) {
      if (state is MyServicesCanceling) {
        print("SE ESTA CANCELANDO EL SERVICIO");
      } else if (state is MyServicesCancelled) {
        Navigator.of(context).pop();
      }
      // TODO: implement listener
    },
    child: Container(
      decoration: BoxDecoration(color: ColorPrimary.primaryColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                right: 8.0, left: 8.0, top: 0, bottom: 10),
            child: Column(
              children: [
                Text(
                  requestedService.servicio.titulo,
                  style: titleLable.copyWith(
                      fontSize: 30, color: ColorNeutral.neutralWhite),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (requestedService.servicio.imagenes.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: requestedService.servicio.imagenes
                  .map((e) => Image.network("https://$baseUrl"))
                  .toList(),
            ),
          verticalSpace12,
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  //padding: EdgeInsets.all(1),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Descripción",
                              style: titleLable.copyWith(
                                  fontSize: 25,
                                  color: ColorPrimary.primaryColor),
                            ),
                            Text(
                              requestedService.servicio.descripcion,
                              style: bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      _statusInfo(
                        "Bonos",
                        requestedService.servicio.horas.toString(),
                        context,
                      ),
                      _statusInfo(
                        "Estado",
                        _statusText(requestedService),
                        context,
                      ),
                      _statusInfo(
                        "Fecha",
                        requestedService.creado.toString(),
                        context,
                      ),
                      _statusInfo(
                        "Vecine",
                        requestedService.solicita.name +
                            " " +
                            requestedService.solicita.lastName,
                        context,
                      ),
                      verticalSpace10,
                      isPending
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BounceButton(
                                buttonSize: ButtonSize.medium,
                                type: ButtonType.primary,
                                label: "RECHAZAR",
                                onPressed: () async {
                                  print("SE QUIERE ENVIAR UN MENSAJE");
                                  bloc
                                    ..add(RejectService(
                                        serviceId: requestedService.id));
                                  /* bool isServiceRequested = await _servicesRepository
                                  .requestServices(service);
                              if (isServiceRequested) {
                                print("SE SOLICITO CON EXITO");
                              } else {
                                print("HUBO UN PROBLEMA SOLICITANDO EL SERVICIO");
                              } */
                                },
                                textColor: Colors.white,
                                iconLeft: Icons.cancel,
                                backgroundColor: ColorButton.cancel,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BounceButton(
                                buttonSize: ButtonSize.medium,
                                type: ButtonType.primary,
                                label: "MENSAJES",
                                onPressed: () async {
                                  print("SE QUIERE ENVIAR UN MENSAJE");
                                },
                                textColor: Colors.white,
                                iconLeft: Icons.chat,
                                backgroundColor: ColorPrimary.primaryDark,
                              ),
                            ),
                      isPending
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BounceButton(
                                buttonSize: ButtonSize.medium,
                                type: ButtonType.primary,
                                label: "ACEPTAR",
                                onPressed: () async {
                                  print("SE QUIERE ACEPTAR EL SERVICIO");
                                  bloc
                                    ..add(AcceptService(
                                        serviceId: requestedService.id));
                                },
                                textColor: Colors.white,
                                iconLeft: Icons.cancel,
                                //backgroundColor: ColorButton.cancel,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BounceButton(
                                buttonSize: ButtonSize.medium,
                                type: ButtonType.primary,
                                label: "CANCELAR",
                                onPressed: () async {
                                  print("SE QUIERE CANCELAR EL SERVICIO");
                                  bloc
                                    ..add(CancelService(
                                        serviceId: requestedService.id));
                                },
                                textColor: Colors.white,
                                iconLeft: Icons.cancel,
                                backgroundColor: ColorButton.cancel,
                              ),
                            ),
                    ],
                  ),
                )),
          )
        ],
      ),
    ),
  );
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

bool _isPending(RequestedServiceDto service) {
  if (service.aceptado) {
    return false;
  } else if (service.cancelado) {
    return false;
  } else {
    return true;
  }
}

Widget _statusInfo(String title, String info, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            title,
            style: titleLable.copyWith(
                fontSize: 25, color: ColorPrimary.primaryColor),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            info,
            style: bodyText1,
          ),
        ),
      ],
    ),
  );
}
