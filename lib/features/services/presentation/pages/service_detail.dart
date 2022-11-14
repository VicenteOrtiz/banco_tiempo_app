import 'package:banco_tiempo_app/app/presentation/shared_widgets/generic_error_pop_up.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../app/presentation/shared_widgets/custom_popup.dart';
import '../../../../app/presentation/shared_widgets/link_button.dart';
import '../../../../cross_features/widgets/appbar_widget.dart';
import '../../../../secrets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../domain/service_entity.dart';
import '../../infraestructure/service_repository.dart';

class ServiceDetail extends StatelessWidget {
  final Service service;
  const ServiceDetail({
    Key? key,
    required Service this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _serviceLayout(context, service),
    );
  }

  Widget _serviceLayout(BuildContext context, Service service) {
    ServicesRepository _servicesRepository = ServicesRepository();
    print("ESTE SERVICIO TIENE: ${service.imagenes.length} IMAGENES");
    return Container(
      decoration: BoxDecoration(color: ColorPrimary.primaryColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                right: 8.0, left: 8.0, top: 0, bottom: 10),
            child: Column(
              children: [
                Text(
                  service.titulo,
                  style: titleLable.copyWith(
                      fontSize: 30, color: ColorNeutral.neutralWhite),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (service.imagenes.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: service.imagenes
                  .map((e) => Image.network("https://$baseUrl${e}"))
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
                      verticalSpace10,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BounceButton(
                          buttonSize: ButtonSize.medium,
                          type: ButtonType.primary,
                          label: "Solicitar",
                          onPressed: () async {
                            print("Se esta solicitando un servicio");
                            /* bool isServiceRequested = await _servicesRepository
                                .requestServices(service); */
                            //bool isServiceRequested;
                            showDialog(
                              context: context,
                              builder: (context) => CustomPopup(
                                message: "Quieres solicitar el servicio?",
                                buttonCancel: BounceButton(
                                  textColor: Colors.white,
                                  type: ButtonType.primary,
                                  buttonSize: ButtonSize.small,
                                  label: "Si",
                                  onPressed: () async {
                                    bool isServiceRequested =
                                        await _servicesRepository
                                            .requestServices(service);
                                    Navigator.of(context)
                                        .pop(isServiceRequested);
                                    //return isServiceRequested;
                                  },
                                ),
                                buttonAccept: BounceButton(
                                  textColor: Colors.white,
                                  type: ButtonType.primary,
                                  buttonSize: ButtonSize.small,
                                  label: "No",
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            ).then((value) {
                              if (value != null) {
                                if (value) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomPopup(
                                      message:
                                          "Su servicio se solicitó con éxito!",
                                      buttonAccept: BounceButton(
                                        textColor: Colors.white,
                                        type: ButtonType.primary,
                                        buttonSize: ButtonSize.small,
                                        label: "Entendido",
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                  ).then(
                                      (value) => Navigator.of(context).pop());
                                } else {
                                  print("HUBO UN PROBLEMA");
                                  showDialog(
                                      context: context,
                                      builder: (context) => GenericErrorPopUp(
                                          message:
                                              "Hubo un problema con la solicitud del servicio"));
                                }
                              }
                            });
                            /* if (isServiceRequested) {
                              print("SE SOLICITO CON EXITO");
                            } else {
                              print("HUBO UN PROBLEMA SOLICITANDO EL SERVICIO");
                            } */
                          },
                          textColor: Colors.white,
                          iconLeft: Icons.calendar_month,
                        ),
                      ),
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
                              service.descripcion,
                              style: bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
