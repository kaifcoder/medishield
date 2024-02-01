import 'package:flutter/material.dart';
import 'package:medishield/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(TSizes.md),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Center(
            child: Image(
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider,
              fit: fit,
            ),
          ),
        ),
      ),
    );
  }
}
