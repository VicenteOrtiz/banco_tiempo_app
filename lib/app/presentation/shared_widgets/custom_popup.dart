//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'bounce_button.dart';
import 'link_button.dart';

//const _translationPath = 'close_form_popup.';

class CustomPopup extends StatelessWidget {
  const CustomPopup({
    Key? key,
    this.context,
    this.title,
    required this.message,
    required this.buttonAccept,
    this.buttonCancel,
    //this.svg,
    this.buttonAcceptFlex,
  }) : super(key: key);

  final BuildContext? context;
  final String? title;
  final String message;
  final Widget buttonAccept;
  final Widget? buttonCancel;
  //final SvgPicture? svg;
  final int? buttonAcceptFlex;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  //vertical: svg != null ? 32 : 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    /* if (svg != null)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: svg,
                        ),
                      ), */
                    if (title != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 16),
                        child: Text(
                          title!,
                          style: appTextTheme.headline6,
                        ),
                      ),
                    Text(
                      message,
                      style: appTextTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 20,
                        runSpacing: 16,
                        children: [
                          if (buttonCancel != null) buttonCancel!,
                          buttonAccept,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> showCancelPopup(
  BuildContext context,
  String title,
  String msg, {
  required VoidCallback onCancel,
}) async {
  return await showDialog<bool>(
        barrierDismissible: true,
        context: context,
        builder: (_) => CustomPopup(
          title: title,
          message: msg,
          buttonAccept: BounceButton(
            buttonSize: ButtonSize.small,
            //label: '${_translationPath}button_continue'.tr(),
            label: "Continuar",
            type: ButtonType.primary,
            contentBasedWidth: true,
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(false),
          ),
          buttonCancel: LinkButton(
            //label: '${_translationPath}button_cancel'.tr(),
            label: "Cancelar",
            mainAxisSize: MainAxisSize.min,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
              onCancel();
            },
          ),
        ),
      ) ??
      false;
}
