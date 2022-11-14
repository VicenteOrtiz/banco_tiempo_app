//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';

import '../../assets_manager.dart';
import 'bounce_button.dart';
import 'custom_popup.dart';

const _translationPath = 'generic_error.';

class GenericErrorPopUp extends StatelessWidget {
  final String? title;
  final String message;

  const GenericErrorPopUp({
    Key? key,
    this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPopup(
      //svg: SvgPicture.asset(AssetsManager.semanticWarning),
      title: title,
      message: message,
      buttonAccept: BounceButton(
        buttonSize: ButtonSize.small,
        type: ButtonType.primary,
        textColor: Colors.white,
        label: "Entendido",
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

void showGenericErrorPopUp(
  BuildContext context,
  String message, {
  String? title,
}) =>
    showDialog(
      context: context,
      builder: (_) => GenericErrorPopUp(
        title: title,
        message: message,
      ),
    );
