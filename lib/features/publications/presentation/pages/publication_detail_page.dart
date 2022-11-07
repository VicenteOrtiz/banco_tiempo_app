import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/publications/domain/publication_entity.dart';
import 'package:banco_tiempo_app/features/publications/presentation/bloc/publication_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../secrets.dart';

class PublicationDetailPage extends StatelessWidget {
  final Publication publication;
  const PublicationDetailPage({
    required this.publication,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(""),
      ),
      body: _serviceLayout(context, publication),
    );
  }
}

Widget _serviceLayout(BuildContext context, Publication publication) {
  print(publication.imagenes.length);
  return BlocListener<PublicationBloc, PublicationState>(
    listener: (context, state) {
      if (state is PublicationHiding) {
        print("SE ESTA ESCONDIENDO EL SERVICIO");
      } else if (state is PublicationHidden) {
        Navigator.of(context).pop();
      } else if (state is PublicationRepublishing) {
        print("SE ESTA REPUBLICANDO EL SERVICIO");
      } else if (state is PublicationRepublished) {
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
                  publication.titulo,
                  style: titleLable.copyWith(
                      fontSize: 30, color: ColorNeutral.neutralWhite),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (publication.imagenes.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: publication.imagenes
                  .map((e) => Image.network("https://$baseUrl" + e))
                  .toList(),
            ),
          //verticalSpace12,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BounceButton(
              buttonSize: ButtonSize.medium,
              type: ButtonType.primary,
              label: "SERVICIOS PENDIENTES",
              onPressed: () async {
                print(publication.inscritos);
                /* print("SE QUIERE OCULTAR EL SERVICIO");
                //bloc..add(CancelService(serviceId: publication.id));
                /* bool isServiceRequested = await _servicesRepository
                                  .requestServices(service);
                              if (isServiceRequested) {
                                print("SE SOLICITO CON EXITO");
                              } else {
                                print("HUBO UN PROBLEMA SOLICITANDO EL SERVICIO");
                              } */
                publication.oculta
                    ? BlocProvider.of<PublicationBloc>(context)
                        .add(RepublishPublication(publication.id))
                    : BlocProvider.of<PublicationBloc>(context)
                        .add(HidePublication(publication.id)); */
              },
              textColor: ColorPrimary.primaryColor,
              backgroundColor: Colors.white,
              iconLeft: Icons.watch,
            ),
          ),
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
                              publication.descripcion,
                              style: bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      _statusInfo(
                        "Bonos",
                        publication.horas.toString(),
                        context,
                      ),
                      _statusInfo(
                        "Estado",
                        _statusText(publication),
                        context,
                      ),
                      /*_statusInfo(
                        "Fecha",
                        publication.creado.toString(),
                        context,
                      ),
                      _statusInfo(
                        "Vecine",
                        publication.ofrece.name +
                            " " +
                            publication.ofrece.lastName,
                        context,
                      ), */
                      verticalSpace10,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BounceButton(
                          buttonSize: ButtonSize.medium,
                          type: ButtonType.primary,
                          label: publication.oculta ? "REPUBLICAR" : "OCULTAR",
                          onPressed: () async {
                            print("SE QUIERE OCULTAR EL SERVICIO");
                            //bloc..add(CancelService(serviceId: publication.id));
                            /* bool isServiceRequested = await _servicesRepository
                                  .requestServices(service);
                              if (isServiceRequested) {
                                print("SE SOLICITO CON EXITO");
                              } else {
                                print("HUBO UN PROBLEMA SOLICITANDO EL SERVICIO");
                              } */
                            publication.oculta
                                ? BlocProvider.of<PublicationBloc>(context)
                                    .add(RepublishPublication(publication.id))
                                : BlocProvider.of<PublicationBloc>(context)
                                    .add(HidePublication(publication.id));
                          },
                          textColor: Colors.white,
                          iconLeft: Icons.cancel,
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

String _statusText(Publication publication) {
  if (publication.oculta) {
    return "Oculto";
  } else {
    return "Publicado";
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
