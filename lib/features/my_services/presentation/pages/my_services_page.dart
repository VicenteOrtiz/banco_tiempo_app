import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/my_services/presentation/bloc/my_services_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyServicesPage extends StatelessWidget {
  const MyServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Mis Servicios"),
      ),
      body: BlocProvider(
        create: (context) => MyServicesBloc()
          ..add(
            GetMyServices(),
          ),
        child: MyServicesBody(),
      ),
    );
  }
}

class MyServicesBody extends StatelessWidget {
  const MyServicesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyServicesBloc, MyServicesState>(
      builder: (context, state) {
        if (state is MyServicesLoaded) {
          return Column(
            children: [
              Text("Servicios Confirmados"),
              Text(
                  "Hay ${state.myServices.solicitado.length} servicios confirmados"),
              Text("Servicios Pendientes"),
              Text(
                  "Hay ${state.myServices.porConfirmar.length} servicios pendientes"),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
