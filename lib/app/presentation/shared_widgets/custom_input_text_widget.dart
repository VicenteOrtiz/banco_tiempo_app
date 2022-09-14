import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_theme.dart';
import 'box_message_widget.dart';

/// Wrapper Widget to use in input text in the App.
/// This widget have the configuration as Figma for all input text field
///
/// The different or additional params
///
/// `width`: set a custom width for default is width of parent
/// `helpMessage`: create a bottom message with example
/// `errorMessage`: when the validation fails bellow
/// this widget we show a [BoxMessageWidget]
/// `errorTitle`: tile for [BoxMessageWidget]
/// `iconSuccessful`: icon when the validation is sucessful
/// for default the color is `SemanticSuccess.approve`
/// `iconError`: icon when the validation is wrong for default
/// the color is `SemanticError.dark` `iconInfo`: icon when
/// the show a info icon for default the color is `ColorPrimary.primaryColor`
/// `showSuccessIcon`: change the icon for `iconSuccessful`
/// `showErrorIcon`: change the icon for `iconError`
/// `padding`: when is false, remove the padding in the default widget
///
///
/// Example:
/// ```dart
/// CustomInputTextWidget(
///   label: 'Phone Numer',
///   helpMessage: 'Ex: 5766181000',
///   errorMessage: error ? 'Error message' : '
///   iconError: Icons.close,
///   iconSuccessful: Icons.check_circle_outline_rounded,
///   showErrorIcon: error,
///   onChanged: (value) {}
/// ),
///```
///
///

//TODO talk with vale about help message and white space
class CustomInputTextWidget extends StatelessWidget {
  const CustomInputTextWidget({
    Key? key,
    this.label = '',
    this.onChanged,
    this.controller,
    this.onTap,
    this.onIconTap,
    this.width,
    this.maxLength = 30,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
    this.helpMessage = '',
    this.errorMessage = '',
    this.errorTitle = '',
    this.iconSuccessful,
    this.iconError,
    this.iconInfo,
    this.inputFormatters,
    this.showSuccessIcon = false,
    this.showErrorIcon = false,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.style,
    this.focusNode,
    this.decoration,
    this.padding = true,
    this.enabled = true,
    this.readOnly = false,
    this.hintText = '',
  }) : super(key: key);

  final String label;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onIconTap;
  final double? width;
  final int maxLines;
  final int maxLength;
  final TextInputType inputType;
  final String helpMessage;
  final String errorMessage;
  final String errorTitle;
  final IconData? iconSuccessful;
  final IconData? iconError;
  final IconData? iconInfo;
  final bool showSuccessIcon;
  final bool showErrorIcon;
  final bool obscureText;
  final TextAlign textAlign;
  final TextStyle? style;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final bool? enabled;
  final bool readOnly;
  final bool padding;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: width ?? size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding ? 16 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              enabled: enabled,
              readOnly: readOnly,
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              enableInteractiveSelection: false,
              enableSuggestions: false,
              keyboardType: inputType,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              textAlign: textAlign,
              maxLines: maxLines,
              cursorColor: Colors.black,
              focusNode: focusNode,
              style: style ??
                  GoogleFonts.firaSans(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
              decoration: decoration ?? defaultDecoration(),
            ),
            Visibility(
              visible: padding,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(helpMessage, style: labels),
              ),
            ),
            Visibility(
              visible: hasError,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: BoxMessageWidget.error(
                  message: errorMessage,
                  title: errorTitle,
                  width: size.width,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Default decoration for the widget
  InputDecoration defaultDecoration() => InputDecoration(
        labelText: label,
        labelStyle: bodyText1Light.copyWith(
          color: ColorNeutral.neutralBlack,
        ),
        hintText: hintText,
        hintStyle: bodyText1Light,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: SemanticError.light),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: SemanticError.light),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorPrimary.primaryColor),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorNeutral.neutral2),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorNeutral.neutral2),
        ),
        counterText: '',
        suffixIcon: GestureDetector(
          onTap: () {
            if (onIconTap != null) {
              onIconTap?.call();
            }
          },
          child: Icon(icon, color: colorIcon, size: IconSize.sm),
        ),
      );

  /// Flag to know if the widget have a error message
  bool get hasError => errorMessage.isNotEmpty || errorTitle.isNotEmpty;

  /// Getter to know what icon put or none
  IconData? get icon {
    if (showErrorIcon && iconError != null) {
      return iconError;
    } else if (!hasError && iconSuccessful != null && showSuccessIcon) {
      return iconSuccessful;
    }

    return iconInfo;
  }

  /// Getter to know what icon Color
  Color get colorIcon {
    if (hasError && iconError != null) {
      return SemanticError.dark;
    } else if (!hasError && iconSuccessful != null && showSuccessIcon) {
      return SemanticApproved.approvedPositive;
    }

    return ColorPrimary.primaryColor;
  }
}
