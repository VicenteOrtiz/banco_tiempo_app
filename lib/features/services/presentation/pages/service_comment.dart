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
import '../../../profile/domain/profile_entity.dart';

class CommentServicePage extends StatelessWidget {
  const CommentServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Text("Consulta y/o Comentario"),
          centerTitle: true,
        ),
        body: CommentServiceBody());
  }
}

//TODO: missing upload images because API is unclear.

class CommentServiceBody extends StatefulWidget {
  const CommentServiceBody({Key? key}) : super(key: key);

  @override
  State<CommentServiceBody> createState() => _CommentServiceBodyState();
}

class _CommentServiceBodyState extends State<CommentServiceBody> {
  late FocusNode commentFocus;
  late TextEditingController commentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentFocus = FocusNode();

    commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is PasswordChanged) {
          print("Fue un exito");
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message: "Has cambiado tu clave con éxito!",
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
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          });
        } else if (state is SettingsError) {
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message: state.error,
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
        if (state is PasswordChanging) {
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
                                  "Contraseña Actual",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: commentFocus,
                                textController: commentController,
                                label: "Contraseña Actual",
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
                              label: "Cambiar Contraseña",
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomPopup(
                                    message: "Quieres cambiar la contraseña?",
                                    buttonCancel: BounceButton(
                                      textColor: Colors.white,
                                      type: ButtonType.primary,
                                      buttonSize: ButtonSize.small,
                                      label: "SI",
                                      onPressed: () {
                                        print("Se quiere comentar");
                                        /* var changePasswordPayload =
                                            ChangePasswordPayload(
                                          password:
                                              commentController.text,
                                          newPasswordConfirmation:
                                              repeatNewPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                        );

                                        BlocProvider.of<SettingsBloc>(context)
                                          ..add(EditPassword(
                                              changePasswordPayload)); */
                                      },
                                    ),
                                    buttonAccept: BounceButton(
                                      textColor: Colors.white,
                                      type: ButtonType.primary,
                                      buttonSize: ButtonSize.small,
                                      label: "NO",
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ),
                                );

                                /* Navigator.of(context).pushNamed(
                              '/publications/create',
                            ); */
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

/* bool validator(RegistrationForm registrationForm) {
  if (registrationForm.name != "" &&
      registrationForm.lastName != "" &&
      registrationForm.comment != "" &&
      registrationForm.repeatNewPassword != "" &&
      registrationForm.rut != "" &&
      registrationForm.email != "" &&
      registrationForm.password != "" &&
      registrationForm.age != 0) {
    print("llego aca, estan todos");
    return true;
  } else {
    print("LLEGO AL ELSE, faltan campos");
    return false;
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(Uri.parse(
      "https://$baseUrl/BDT_Terminos_y_Condiciones-a078371d63.pdf"))) {
    throw 'Could not launch';
  }
} */
