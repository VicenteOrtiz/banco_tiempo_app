import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/presentation/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/presentation/shared_widgets/image_builder.dart';
import '../../features/messages_poc/presentation/bloc/messages_bloc.dart';
import 'in_progress_dialog.dart';

Widget DrawerWidget(BuildContext context) {
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );
}

Widget buildHeader(BuildContext context) => Container(
      color: ColorPrimary.primaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/images/logo_banco.png',
              width: 200,
            ),
          )
        ],
      ),
    );

Widget buildMenuItems(BuildContext context) => Container(
      padding: EdgeInsets.all(12),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(
              Icons.search,
              color: ColorPrimary.primaryColor,
            ),
            title: const Text("Buscar Servicio"),
            onTap: () {
              Navigator.of(context).pushNamed('/service');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.list,
              color: ColorPrimary.primaryColor,
            ),
            title: const Text("Mis Servicios"),
            onTap: () {
              Navigator.of(context).pushNamed('/my-services');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.lock_clock,
              color: ColorPrimary.primaryColor,
            ),
            title: const Text("Mis Publicaciones"),
            onTap: () {
              Navigator.of(context).pushNamed('/publications');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.mail,
              color: ColorPrimary.primaryColor,
            ),
            title: const Text("Mensajes"),
            onTap: () {
              BlocProvider.of<MessagesBloc>(context)..add(GetPendingMessages());
              Navigator.of(context).pushNamed('/pending-messages');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help,
              color: ColorPrimary.primaryColor,
            ),
            title: const Text("Ayuda"),
            onTap: () {
              dialog(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: ColorPrimary.primaryColor,
            ),
            title: const Text("Mi Cuenta"),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          Divider(
            color: ColorPrimary.primaryColor,
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: ColorPrimary.primaryColor,
            ),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/", ModalRoute.withName("/"));
            },
          )
        ],
      ),
    );
