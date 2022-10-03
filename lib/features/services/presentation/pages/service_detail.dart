import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:banco_tiempo_app/app/presentation/shared_widgets/bounce_button.dart';
import 'package:banco_tiempo_app/app/presentation/shared_widgets/link_button.dart';
import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/secrets.dart';
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
                            bool isServiceRequested = await _servicesRepository
                                .requestServices(service);
                            if (isServiceRequested) {
                              print("SE SOLICITO CON EXITO");
                            } else {
                              print("HUBO UN PROBLEMA SOLICITANDO EL SERVICIO");
                            }
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
