import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medihealth/common/widgets/icons/t_circular_icon.dart';
import 'package:medihealth/utils/constants/colors.dart';
import 'package:medihealth/utils/constants/sizes.dart';

class BottomAddToCartBar extends StatelessWidget {
  const BottomAddToCartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
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
              TCircularIcon(
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
              TCircularIcon(
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
                  padding: EdgeInsets.all(TSizes.md),
                  backgroundColor: TColors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  ),
                  side: BorderSide(color: TColors.black)),
              onPressed: () {},
              child: Text('Add to cart'))
        ],
      ),
    );
  }
}
