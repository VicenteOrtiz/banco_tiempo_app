import 'package:flutter/material.dart';

import '../../../../app/presentation/app_theme.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.focusNode,
    required this.textController,
    required this.label,
    required this.icons,
    required this.isPassword,
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController textController;
  final String label;
  final Icon icons;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kHPadding,
      child: TextFormField(
        style: TextStyle(color: ColorNeutral.neutralWhite),
        obscureText: isPassword,
        controller: textController,
        autofocus: false,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(focusNode);
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorNeutral.neutralWhite),
                borderRadius: kBorderRadius),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorNeutral.neutralWhite),
                borderRadius: kBorderRadius),
            hintStyle: const TextStyle(color: ColorNeutral.neutralWhite),
            filled: true,
            fillColor: Colors.transparent,
            hintText: label,
            prefixIcon: icons),
      ),
    );
  }
}
