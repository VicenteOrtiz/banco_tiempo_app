import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/presentation/shared_widgets/image_builder.dart';

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
            leading: const Icon(Icons.home_filled),
            title: const Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home_filled),
            title: const Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home_filled),
            title: const Text("Home"),
            onTap: () {},
          ),
          Divider(
            color: ColorPrimary.primaryColor,
          ),
          ListTile(
            leading: const Icon(Icons.home_filled),
            title: const Text("Home"),
            onTap: () {},
          ),
        ],
      ),
    );
