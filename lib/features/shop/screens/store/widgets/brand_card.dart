import 'package:flutter/material.dart';
import 'package:medihealth/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medihealth/common/widgets/images/t_circular_image.dart';
import 'package:medihealth/common/widgets/text/t_brand_title_text.dart';
import 'package:medihealth/utils/constants/colors.dart';
import 'package:medihealth/utils/constants/enums.dart';
import 'package:medihealth/utils/constants/image_strings.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/helpers/helper_functions.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    this.onPressed,
    this.image = TImages.clothIcon,
    this.title = 'Brand Name',
    this.subtitle,
  });

  final void Function()? onPressed;
  final String? image;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: true,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: TCircularImage(
                image: TImages.clothIcon,
                overlayColor: THelperFunctions.isDarkMode(context)
                    ? TColors.white
                    : TColors.black,
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleText(
                    title: title,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    subtitle ?? 'Subtitle',
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                          color: THelperFunctions.isDarkMode(context)
                              ? TColors.white
                              : TColors.black,
                        ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
