import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:banco_tiempo_app/features/services/infraestructure/payload/service_payload.dart';
import 'package:banco_tiempo_app/features/services/presentation/bloc/service_bloc.dart';
import 'package:banco_tiempo_app/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/service_entity.dart';
import '../controller/service_controller.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Servicios, Talentos o Bienes"),
      ),
      body: BlocProvider<ServiceBloc>(
        create: (context) => ServiceBloc()..add(GetServices()),
        child: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            if (state is ServiceLoaded) {
              print(state);
              //print(state.actualPage);
              //print(state.pages);
              //print(state.services);
              /* return Container(
                child: Text(state.services[0].titulo),
              ); */
              //return _buildServicesList(state.services);
              return _serviceLayout(context, state.serviceController!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _serviceLayout(
      BuildContext context, ServiceController serviceController) {
    return Container(
      decoration: BoxDecoration(color: ColorPrimary.primaryColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                right: 8.0, left: 8.0, top: 10, bottom: 0),
            child: Column(
              children: [
                //Text("Hola"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: _buildServicesList(serviceController, context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesList(
      ServiceController serviceController, BuildContext context) {
    ServiceBloc _serviceBloc = context.read<ServiceBloc>();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: serviceController.services.length,
      itemBuilder: ((context, index) {
        if (index == serviceController.services.length - 1) {
          print(serviceController.services.length);
          ServicePayload payload = ServicePayload(
            categorias: [],
            pagina: serviceController.actualPage,
            query: "",
          );
          _serviceBloc
            ..add(GetServices(
                serviceController: serviceController, servicePayload: payload));
        }
        return _serviceBox(serviceController.services[index]);
      }),
    );
  }

  Widget _serviceBox(Service service) {
    return InkWell(
      onTap: () => print("TE AMO VALENTINA"),
      child: Container(
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
}

/* class ServiceList extends StatefulWidget {
  const ServiceList({Key? key});

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
} */