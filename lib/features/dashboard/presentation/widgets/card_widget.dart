import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../cross_features/widgets/in_progress_dialog.dart';
import '../../../messages_poc/presentation/bloc/messages_bloc.dart';

Widget CardWidget(int opt, BuildContext context) {
  List<String> titles = [
    "Buscar Servicio",
    "Mis Servicios",
    "Mis Publicaciones",
    "Mensajes",
    "Ayuda",
    "Mi Cuenta"
  ];
  List<IconData> icons = [
    Icons.search,
    Icons.list,
    Icons.lock_clock,
    Icons.mail,
    Icons.help,
    Icons.person
  ];

  return InkWell(
    onTap: () {
      if (opt == 0) {
        Navigator.of(context).pushNamed('/service');
      } else if (opt == 1) {
        Navigator.of(context).pushNamed('/my-services');
      } else if (opt == 2) {
        Navigator.of(context).pushNamed('/publications');
      } else if (opt == 3) {
        BlocProvider.of<MessagesBloc>(context)..add(GetPendingMessages());
        Navigator.of(context).pushNamed('/pending-messages');
      } else if (opt == 4) {
        //Navigator.of(context).pushNamed('/services-list');
        dialog(context);
      } else if (opt == 5) {
        Navigator.of(context).pushNamed('/profile');
      }
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15))),
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icons[opt], size: 70, color: ColorPrimary.primaryColor),
          Text(titles[opt])
        ],
      ),
    ),
  );
}
