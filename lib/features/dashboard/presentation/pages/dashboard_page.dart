import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:banco_tiempo_app/cross_features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:banco_tiempo_app/cross_features/widgets/drawer_widget.dart';
import 'package:banco_tiempo_app/features/dashboard/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/loader.dart';
import '../../../../core/config/services/secure_storage.dart';
import '../bloc/dashboard_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key, required this.title, required this.username})
      : super(key: key);

  final String title;
  final String username;

  @override
  Widget build(BuildContext context) {
    final StorageService _storageService = StorageService();
    _storageService.getToken().then(
          (value) => print(value),
        );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        //title: Text(title),
        backgroundColor: ColorPrimary.primaryColor,
      ),
      drawer: DrawerWidget(context),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardNav) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return LoadingWidget(
              child: initialLayout(context),
            );
          } else {
            return initialLayout(context);
          }
        },
      ),
    );
  }

  Widget initialLayout(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(color: ColorPrimary.primaryColor),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 10, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenido",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          state.name!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w100),
                        ),
                        Text(
                          "Tienes ${state.balance} bonos disponibles",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    //Icon(Icons.person)
                    CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "https://bancotiempo.cl${state.imageUrl}"),
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),

              //SizedBox(height: 200,),

              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardWidget(0, context),
                            CardWidget(1, context)
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardWidget(2, context),
                            CardWidget(3, context)
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardWidget(4, context),
                            CardWidget(5, context)
                          ],
                        ),
                      ]),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
