import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/common/widgets/images/t_circular_image.dart';
import 'package:medishield/common/widgets/text/t_brand_title_text.dart';
import 'package:medishield/utils/constants/enums.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    this.onPressed,
    this.image = TImages.clothIcon,
    this.title = 'Brand Name',
    this.subtitle,
    this.isNetworkImage = false,
  });

  final void Function()? onPressed;
  final String? image;
  final String title;
  final String? subtitle;
  final bool? isNetworkImage;

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
                isNetworkImage: isNetworkImage ?? false,
                image: image ?? TImages.clothIcon,
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
