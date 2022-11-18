import 'package:banco_tiempo_app/cross_features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';
import 'package:banco_tiempo_app/features/registration/domain/registration_form_entity.dart';
import 'package:banco_tiempo_app/features/settings/domain/edit_profile_entity.dart';
import 'package:banco_tiempo_app/features/settings/infraestructure/payload/change_password_payload.dart';
import 'package:banco_tiempo_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:banco_tiempo_app/secrets.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/custom_popup.dart';
import '../../../../cross_features/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../cross_features/authentication/presentation/widgets/input_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Text("Recuperar Contraseña"),
          centerTitle: true,
        ),
        body: ForgotPasswordBody());
  }
}

//TODO: missing upload images because API is unclear.

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  late FocusNode mailFocus;
  late TextEditingController mailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mailFocus = FocusNode();

    mailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is PasswordRecovered) {
          print("Fue un exito");
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message:
                  "Se ha enviado un correo con un enlace para cambiar la contraseña!",
              buttonAccept: BounceButton(
                textColor: Colors.white,
                type: ButtonType.primary,
                buttonSize: ButtonSize.small,
                label: "Entendido",
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ).then((value) {
            Navigator.of(context).pop();
            //Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          });
        } else if (state is AuthenticationError) {
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message: state.message ?? "Hubo un error no conocido",
              buttonAccept: BounceButton(
                textColor: Colors.white,
                type: ButtonType.primary,
                buttonSize: ButtonSize.small,
                label: "Entendido",
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          );
          print("Paso algo");
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PasswordRecovering) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else
          return Container(
            decoration: BoxDecoration(color: ColorPrimary.primaryColor),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Correo",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: mailFocus,
                                textController: mailController,
                                label: "Ingrese su Correo",
                                icons: const Icon(Icons.person,
                                    color: ColorNeutral.neutralWhite),
                                isPassword: false,
                                backgroundColor: ColorPrimary.primaryColor,
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BounceButton(
                              buttonSize: ButtonSize.medium,
                              type: ButtonType.primary,
                              label: "Recuperar Contraseña",
                              onPressed: () async {
                                print("Quiere recuperar la contraseña");
                                BlocProvider.of<AuthenticationBloc>(context)
                                  ..add(RecoverPassword(mailController.text));
                              },
                              textColor: ColorNeutral.neutralWhite,
                              iconLeft: Icons.add_box,
                              backgroundColor: ColorPrimary.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
      },
    );
  }
}
