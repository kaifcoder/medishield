import 'package:flutter/material.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.border,
    this.padding,
    this.margin,
    this.onPressed,
    this.backgroundColor = TColors.light,
    this.showBorder = false,
    this.borderRadius = TSizes.cardRadiusLg,
    this.borderColor = TColors.borderPrimary,
  });

  final double? width, height;
  final BoxBorder? border;
  final Color backgroundColor;
  final Color borderColor;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showBorder;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          border: showBorder ? Border.all(color: borderColor) : null,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}
