import 'package:flutter/material.dart';

import '../app_theme.dart';

class BoxMessageWidget extends StatelessWidget {
  const BoxMessageWidget._({
    Key? key,
    required this.message,
    required this.title,
    required this.width,
    required this.icon,
    required this.contentColor,
    required this.borderColor,
    this.rotate = false,
    this.isSpecial = false,
  }) : super(key: key);

  factory BoxMessageWidget.success({
    Key? key,
    required String message,
    required String title,
    required double width,
  }) =>
      BoxMessageWidget._(
        key: key,
        message: message,
        title: title,
        width: width,
        icon: Icons.done,
        contentColor: SemanticSuccess.light,
        borderColor: SemanticSuccess.dark,
        isSpecial: true,
      );

  factory BoxMessageWidget.error({
    Key? key,
    required String message,
    required String title,
    required double width,
  }) =>
      BoxMessageWidget._(
        key: key,
        message: message,
        title: title,
        width: width,
        icon: Icons.close,
        contentColor: SemanticError.light,
        borderColor: SemanticError.dark,
        isSpecial: true,
      );

  factory BoxMessageWidget.warning({
    Key? key,
    required String message,
    required String title,
    required double width,
  }) =>
      BoxMessageWidget._(
        key: key,
        message: message,
        title: title,
        width: width,
        icon: Icons.warning,
        contentColor: SemanticWarning.light,
        borderColor: SemanticWarning.dark,
      );

  factory BoxMessageWidget.info({
    Key? key,
    required String message,
    required String title,
    required double width,
  }) =>
      BoxMessageWidget._(
        key: key,
        message: message,
        title: title,
        width: width,
        icon: Icons.error_rounded,
        contentColor: SemanticInfo.light,
        borderColor: SemanticInfo.dark,
        rotate: true,
      );

  factory BoxMessageWidget.alternative({
    Key? key,
    required String message,
    required String title,
    required double width,
  }) =>
      BoxMessageWidget._(
        key: key,
        message: message,
        title: title,
        width: width,
        icon: Icons.star,
        contentColor: SemanticAlternative.light,
        borderColor: SemanticAlternative.dark,
      );

  final String message;
  final String title;
  final double width;
  final IconData icon;
  final Color contentColor;
  final Color borderColor;
  final bool rotate;
  final bool isSpecial;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final _dismmissActivationAlert = ValueNotifier<bool>(true);
    Future.delayed(const Duration(milliseconds: 4000), () {
      _dismmissActivationAlert.value = false;
    });

    return ValueListenableBuilder<bool>(
      valueListenable: _dismmissActivationAlert,
      builder: (context, visible, child) => Visibility(
        visible: visible,
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: contentColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isSpecial)
                Icon(
                  icon,
                  color: Colors.black,
                  size: 25,
                )
              else
                CircleAvatar(
                  maxRadius: 13,
                  backgroundColor: Colors.black,
                  child: Icon(
                    icon,
                    color: contentColor,
                    size: 25,
                  ),
                ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: title.isNotEmpty,
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: textTheme.subtitle1,
                          ),
                          verticalSpace10,
                        ],
                      ),
                    ),
                    Visibility(
                      visible: message.isNotEmpty,
                      child: Column(
                        children: [
                          Text(
                            message,
                            style: textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
