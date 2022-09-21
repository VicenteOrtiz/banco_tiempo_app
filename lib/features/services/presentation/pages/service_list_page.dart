import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:banco_tiempo_app/features/services/presentation/bloc/service_bloc.dart';
import 'package:banco_tiempo_app/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/service_entity.dart';

class ServiceListPage extends StatelessWidget {
  const ServiceListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Servicios, Talentos o Bienes"),
      ),
      body: BlocProvider<ServiceBloc>(
        create: (context) => ServiceBloc()..add(RefreshServices()),
        child: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            if (state is ServiceLoaded) {
              /* return Container(
                child: Text(state.services[0].titulo),
              ); */
              //return _buildServicesList(state.services);
              return _serviceLayout(context, state.services);
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

  Widget _serviceLayout(BuildContext context, List<Service> services) {
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
              child: _buildServicesList(services),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesList(List<Service> services) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: services.length,
      itemBuilder: ((context, index) {
        //return Text(services[index].descripcion);
        return _serviceBox(services[index]);
      }),
    );
  }

  Widget _serviceBox(Service service) {
    print(service.imagenes);
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
      print("https://${baseUrl}${imagenes.first}");
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
