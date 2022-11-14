import 'package:flutter/material.dart';

import '../../app/presentation/app_theme.dart';

class CustomAppBar extends PreferredSize {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget>? actions;
  final double? elevation;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final bool? centerTitle;
  final VoidCallback? customBack;

  const CustomAppBar({
    Key? key,
    this.actions,
    this.elevation,
    this.shape,
    this.backgroundColor,
    this.centerTitle,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title = const SizedBox(),
    this.customBack,
  }) : super(
          key: key,
          child: title,
          preferredSize: const Size.fromHeight(80),
        );

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      elevation: 0.0,
      title: title,
      backgroundColor: ColorPrimary.primaryColor,
      centerTitle: centerTitle ?? false,
      actions: [
        InkWell(
          child: Icon(Icons.notifications),
          onTap: () {
            print("ALGO PASA CON LAS NOTIFICACIONES");
          },
        ),
        horizontalSpace16,
      ],
    );
  }
}
