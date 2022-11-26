import 'package:flutter/material.dart';

import 'package:banco_tiempo_app/cross_features/public_profile/domain/public_profile.dart';
import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/profile/domain/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../messages_poc/presentation/bloc/messages_bloc.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPrimary.primaryColor,
        child: Icon(Icons.home),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/dashboard', (route) => false);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: CustomAppBar(
        title: Text("Ayuda"),
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
                          label: "Guía de uso para les Usuaries",
                          onPressed: () async {
                            _launchUrl(
                                "https://bancotiempo.cl/PPT_MANUAL%20DE%20USO_USUARIO-a06e20907d.pdf");
                            /* Navigator.of(context)
                                .pushNamed("/profile/edit", arguments: profile); */
                          },
                          textColor: ColorNeutral.neutralWhite,
                          iconLeft: Icons.edit,
                          backgroundColor: ColorPrimary.primaryColor,
                        ),
                        verticalSpace20,
                        BounceButton(
                          buttonSize: ButtonSize.medium,
                          type: ButtonType.primary,
                          label: "Normas básicas de convivencia",
                          onPressed: () async {
                            _launchUrl(
                                "https://bancotiempo.cl/Protocolo%20de%20Buen%20Trato-3b2da5a5be.pdf");
                            /* Navigator.of(context)
                                .pushNamed("/contact/edit", arguments: profile); */
                          },
                          textColor: ColorNeutral.neutralWhite,
                          iconLeft: Icons.edit_attributes,
                          backgroundColor: ColorPrimary.primaryColor,
                        ),
                        verticalSpace20,
                        BounceButton(
                          buttonSize: ButtonSize.medium,
                          type: ButtonType.primary,
                          label: "Enviar mensaje a administración",
                          onPressed: () async {
                            BlocProvider.of<MessagesBloc>(context)
                              ..add(GetHelpMessages());
                            Navigator.of(context).pushNamed('/help/messages');
                          },
                          textColor: ColorNeutral.neutralWhite,
                          iconLeft: Icons.send,
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

Future<void> _launchUrl(String fileUr) async {
  if (!await launchUrl(Uri.parse(fileUr))) {
    throw 'Could not launch';
  }
}
