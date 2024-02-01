import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.title,
    required this.image,
    required this.textColor,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = false,
  });

  final String title, image;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56,
              width: 56,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ?? (dark ? TColors.black : TColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                  child: isNetworkImage
                      ? CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const CustomShimmer(
                            height: 55,
                            width: 55,
                            radius: 55,
                          ),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : Image.asset(
                          image,
                          fit: BoxFit.cover,
                        )),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            SizedBox(
              width: 70,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
