import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/icons/t_circular_icon.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class BottomAddToCartBar extends StatelessWidget {
  const BottomAddToCartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: const BoxDecoration(
        color: TColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.darkGrey,
                color: TColors.white,
                height: 40,
                width: 40,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                '1',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(color: TColors.black),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              const TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.black,
                color: TColors.white,
                height: 40,
                width: 40,
              ),
            ],
          ),

          //add to cart button
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: TColors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  ),
                  side: const BorderSide(color: TColors.black)),
              onPressed: () {},
              child: const Text('Add to cart'))
        ],
      ),
    );
  }
}
