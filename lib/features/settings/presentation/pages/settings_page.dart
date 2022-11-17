import 'package:banco_tiempo_app/cross_features/public_profile/domain/public_profile.dart';
import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/profile/domain/profile_entity.dart';
import 'package:flutter/material.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/bounce_button.dart';

class SettingsPage extends StatelessWidget {
  final Profile profile;
  final PublicProfile publicProfile;
  const SettingsPage({
    Key? key,
    required this.profile,
    required this.publicProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Editar"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: ColorPrimary.primaryColor),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8.0, top: 0, bottom: 0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* Text(
                      profile.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ), */
                    ],
                  ),
                  //Icon(Icons.person)
                ],
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
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        verticalSpace20,
                        BounceButton(
                          buttonSize: ButtonSize.medium,
                          type: ButtonType.primary,
                          label: "Datos Personales",
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed("/profile/edit", arguments: profile);
                          },
                          textColor: ColorNeutral.neutralWhite,
                          iconLeft: Icons.edit,
                          backgroundColor: ColorPrimary.primaryColor,
                        ),
                        verticalSpace20,
                        BounceButton(
                          buttonSize: ButtonSize.medium,
                          type: ButtonType.primary,
                          label: "Datos de Contacto",
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed("/contact/edit", arguments: profile);
                          },
                          textColor: ColorNeutral.neutralWhite,
                          iconLeft: Icons.edit_attributes,
                          backgroundColor: ColorPrimary.primaryColor,
                        ),
                        verticalSpace20,
                        BounceButton(
                          buttonSize: ButtonSize.medium,
                          type: ButtonType.primary,
                          label: "Cambiar Contraseña",
                          onPressed: () async {
                            Navigator.of(context).pushNamed("/change-password");
                          },
                          textColor: ColorNeutral.neutralWhite,
                          iconLeft: Icons.password,
                          backgroundColor: ColorPrimary.primaryColor,
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
}
