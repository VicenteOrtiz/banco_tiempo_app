import 'package:flutter/material.dart';

import '../app_theme.dart';

const size8 = 8.0;
const size12 = 12.0;
const size16 = 16.0;
const size20 = 20.0;
const size24 = 24.0;
const size32 = 32.0;
const size40 = 40.0;
const size48 = 48.0;
const size64 = 64.0;
const size80 = 80.0;

const elevation1 = BoxShadow(
  color: Color(0x1A000000),
  blurRadius: 7,
  offset: Offset(1, 1),
);
const elevation2 = BoxShadow(
  color: Color(0x26000000),
  blurRadius: 10,
  offset: Offset(3, 3),
);
const elevation3 = BoxShadow(
  color: Color(0x33000000),
  blurRadius: 15,
  offset: Offset(5, 5),
);
const elevation4 = BoxShadow(
  color: Color(0x40000000),
  blurRadius: 20,
  offset: Offset(7, 7),
);

const primaryColor = ColorPrimary.primaryColor;
const primaryColorDark = ColorPrimary.primaryDark;
const neutral1Color = ColorNeutral.neutral1;
const neutral3Color = ColorNeutral.neutral3;

enum ButtonType { primary, secondary }

enum ButtonSize { small, medium }

class BounceButton extends StatefulWidget {
  final ButtonType type;
  final ButtonSize buttonSize;
  final VoidCallback? onPressed;
  final IconData? iconRight;
  final IconData? iconLeft;
  final String label;
  final Color textColor;
  //TODO make default true, review implementations
  final bool contentBasedWidth;
  final bool horizontalPadding;

  const BounceButton({
    Key? key,
    this.onPressed,
    this.iconRight,
    this.iconLeft,
    this.textColor = Colors.black,
    this.contentBasedWidth = false,
    this.horizontalPadding = true,
    required this.buttonSize,
    required this.type,
    required this.label,
  }) : super(key: key);

  @override
  State<BounceButton> createState() => _BounceButtonState();
}

class _BounceButtonState extends State<BounceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );

    _bounceAnimation = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(CurvedAnimation(
      curve: const Interval(0, 0.3, curve: Curves.decelerate),
      parent: _controller,
    ));

    _colorAnimation = ColorTween(
      begin: primaryColor,
      end: primaryColorDark,
    ).animate(CurvedAnimation(
      curve: const Interval(0.8, 1, curve: Curves.decelerate),
      parent: _controller,
    ));

    super.initState();
  }

  Widget? _buildBtn() {
    Widget? wdgt;
    switch (widget.type) {
      case ButtonType.primary:
        wdgt = _buildPrimaryButton();
        break;
      case ButtonType.secondary:
        wdgt = _buildSecondaryButton();
    }
    return wdgt;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPrimaryButton() {
    return BaseButton(
      size: widget.buttonSize,
      buttonLabel: widget.label,
      leftIcon: widget.iconLeft,
      rightIcon: widget.iconRight,
      backgroundColor: _colorAnimation.value,
      onPressed: widget.onPressed,
      textColor: widget.textColor,
      contentBasedWidth: widget.contentBasedWidth,
      horizontalPadding: widget.horizontalPadding,
    );
  }

  Widget _buildSecondaryButton() {
    return BaseButton(
      size: widget.buttonSize,
      buttonLabel: widget.label,
      backgroundColor: Colors.white,
      textColor: widget.textColor,
      leftIcon: widget.iconLeft,
      rightIcon: widget.iconRight,
      disabledBackgroundColor: Colors.white,
      borderColor: _colorAnimation.value,
      disabledBorderColor: neutral1Color,
      onPressed: widget.onPressed,
      contentBasedWidth: widget.contentBasedWidth,
      horizontalPadding: widget.horizontalPadding,
    );
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onPressed == null;
    return AbsorbPointer(
      absorbing: disabled,
      child: GestureDetector(
        onTapUp: _tapUp,
        onTapDown: _tapDown,
        onTapCancel: _tapCancel,
        onTap: widget.onPressed,
        child: ScaleTransition(
          scale: _bounceAnimation,
          child: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (_, child) => _buildBtn()!,
          ),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _tapCancel() {
    _controller.reverse();
  }
}

class BaseButton extends StatelessWidget {
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String buttonLabel;
  final Color? textColor;
  final Color disabledTextColor;
  final Color? backgroundColor;
  final Color disabledBackgroundColor;
  final VoidCallback? onPressed;
  final Border? border;
  final Color? disabledBorderColor;
  final Color? borderColor;
  final ButtonSize size;
  final bool contentBasedWidth;
  final bool horizontalPadding;

  const BaseButton({
    Key? key,
    this.textColor = Colors.black,
    this.leftIcon,
    this.rightIcon,
    this.buttonLabel = '',
    this.onPressed,
    this.backgroundColor = primaryColorDark,
    this.disabledBackgroundColor = neutral1Color,
    this.disabledTextColor = neutral3Color,
    this.border,
    this.disabledBorderColor,
    this.borderColor,
    required this.size,
    this.contentBasedWidth = false,
    this.horizontalPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);
    final disabled = onPressed == null;
    final bgColor = disabled ? disabledBackgroundColor : backgroundColor;
    final txtColor = disabled ? disabledTextColor : textColor;
    final border = borderColor != null
        ? Border.all(
            color: disabled ? disabledBorderColor! : borderColor!,
            width: 2,
          )
        : null;

    double? iconSize;
    late double widthPadding;
    late double heightPadding;
    double? innerPaddingRight;
    double? innerPaddingLeft;

    switch (size) {
      case ButtonSize.medium:
        iconSize = size24;
        heightPadding = size12;
        widthPadding = size24;
        innerPaddingRight = rightIcon != null ? size24 : size48;
        innerPaddingLeft = leftIcon != null ? size24 : size48;
        break;
      case ButtonSize.small:
        iconSize = size20;
        heightPadding = size8;
        widthPadding = 12;
        innerPaddingRight = rightIcon != null
            ? size12
            : horizontalPadding && textScaleFactor <= 1
                ? size24
                : 0;
        innerPaddingLeft = leftIcon != null
            ? size12
            : horizontalPadding && textScaleFactor <= 1
                ? size24
                : 0;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: heightPadding,
        horizontal: widthPadding,
      ),
      width: contentBasedWidth ? null : double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          if (!disabled) elevation2,
        ],
        color: bgColor,
        border: border,
      ),
      child: _buildContentContainer(
        contentBasedWidth: contentBasedWidth,
        leftIcon: _buildIconOrBlankSpace(
          icon: leftIcon,
          iconSize: iconSize,
          colorIcon: txtColor,
        ),
        label: _buildTextLabel(
            colorText: txtColor,
            leftPadding: innerPaddingLeft,
            rightPadding: innerPaddingRight),
        rightIcon: _buildIconOrBlankSpace(
          icon: rightIcon,
          colorIcon: txtColor,
          iconSize: iconSize,
        ),
      ),
    );
  }

  Widget _buildContentContainer(
      {required bool contentBasedWidth,
      required Widget leftIcon,
      required Widget label,
      required Widget rightIcon}) {
    return contentBasedWidth
        ? Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [leftIcon, label, rightIcon],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [leftIcon, Expanded(child: label), rightIcon],
          );
  }

  Widget _buildTextLabel(
      {required Color? colorText,
      required double leftPadding,
      required double rightPadding}) {
    final style = size == ButtonSize.small ? buttonSmall : buttonMedium;
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding,
        right: rightPadding,
      ),
      child: Text(
        buttonLabel.toUpperCase(),
        textAlign: TextAlign.center,
        style: style.copyWith(color: colorText),
      ),
    );
  }

  Widget _buildIconOrBlankSpace(
      {IconData? icon, Color? colorIcon, required double? iconSize}) {
    return icon != null
        ? Icon(
            icon,
            size: iconSize,
            color: colorIcon,
          )
        : const SizedBox();
  }
}
