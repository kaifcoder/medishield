import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/styles/shadow.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/features/shop/screens/product_details/product_details.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/enums.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

import '../../icons/t_circular_icon.dart';
import '../../text/price_text.dart';
import '../../text/product_title_text.dart';
import '../../text/t_brand_title_text.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailScreen()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.light,
        ),
        child: Column(
          children: [
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(children: [
                const TRoundedImage(imageUrl: TImages.productImage1),
                Positioned(
                  top: 12,
                  child: TRoundedContainer(
                    borderRadius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text(
                      '25%',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.black),
                    ),
                  ), // TRoundedContainer
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: TCircularIcon(
                    dark: dark,
                    icon: Iconsax.heart5,
                    color: Colors.red,
                  ),
                )
              ]),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// -- Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProductTitleText(
                    title: 'Green Nike air shoes adfasdfasdfadfadfsdfafasdfadf',
                    smallSize: true,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TBrandTitleText(
                    title: 'Nike',
                    maxLines: 1,
                    textColor: dark ? TColors.white : TColors.black,
                    textAlign: TextAlign.start,
                    brandTextSize: TextSizes.small,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: PriceText(
                    price: '2000',
                    maxLines: 1,
                    isLarge: false,
                    isLineThrough: false,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ), // BorderRadius.only
                  ), // BoxDecoration
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child:
                        Center(child: Icon(Iconsax.add, color: TColors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
