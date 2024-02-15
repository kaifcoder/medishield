import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    this.isNetworkImage = false,
    this.height = 60,
    this.width = 60,
    this.padding = TSizes.sm,
    required this.image,
    this.overlayColor,
    this.backgroundColor,
  });

  final BoxFit? fit;
  final bool isNetworkImage;
  final double height, width, padding;
  final String image;
  final Color? overlayColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.dark
                : TColors.light),
        borderRadius: BorderRadius.circular(100),
      ),
      child: isNetworkImage
          ? CachedNetworkImage(
              imageUrl: isNetworkImage ? image : '',
              placeholder: (context, url) => const Center(
                child: CustomShimmer(
                  height: double.infinity,
                  width: double.infinity,
                  radius: 100,
                ),
              ),
              errorListener: (value) {
                debugPrint('Error: $value');
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : Image.asset(image),
    );
  }
}
