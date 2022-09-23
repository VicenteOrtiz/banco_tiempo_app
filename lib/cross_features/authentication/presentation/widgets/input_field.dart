import 'package:flutter/material.dart';

import '../../../../app/presentation/app_theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.focusNode,
      required this.textController,
      required this.label,
      required this.icons,
      required this.isPassword,
      this.backgroundColor,
      this.padding,
      this.color})
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController textController;
  final String label;
  final Icon icons;
  final bool isPassword;
  final Color? backgroundColor;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? kHPadding,
      child: TextFormField(
        style: TextStyle(color: color ?? ColorNeutral.neutralWhite),
        obscureText: isPassword,
        controller: textController,
        autofocus: false,
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(focusNode);
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: color ?? ColorNeutral.neutralWhite),
                borderRadius: kBorderRadius),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: color ?? ColorNeutral.neutralWhite),
                borderRadius: kBorderRadius),
            hintStyle: TextStyle(color: color ?? ColorNeutral.neutralWhite),
            filled: true,
            fillColor: backgroundColor ?? Colors.transparent,
            hintText: label,
            prefixIcon: icons),
      ),
    );
  }
}
