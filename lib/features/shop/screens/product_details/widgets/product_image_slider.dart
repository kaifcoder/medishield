import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/curved_edges/t_curved_edge_widget.dart';
import 'package:medishield/common/widgets/icons/t_circular_icon.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            const SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Image(
                    image: AssetImage(
                      TImages.productImage1,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 30,
              left: TSizes.sm,
              child: SizedBox(
                height: 60,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => TRoundedImage(
                          width: 60,
                          border: Border.all(color: TColors.primary),
                          backgroundColor: dark ? TColors.dark : TColors.light,
                          padding: const EdgeInsets.all(TSizes.sm / 2),
                          imageUrl: TImages.productImage1,
                        ),
                    separatorBuilder: (_, __) => const SizedBox(
                          width: TSizes.spaceBtwItems / 2,
                        ),
                    itemCount: 6),
              ),
            ),
            TAppBar(
              showBackArrow: true,
              actions: [
                TCircularIcon(
                  dark: dark,
                  onPressed: () {},
                  icon: Iconsax.heart5,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
