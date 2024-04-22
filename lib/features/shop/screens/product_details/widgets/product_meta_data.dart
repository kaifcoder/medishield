import 'package:flutter/material.dart';
import 'package:medishield/features/shop/controllers/location_controller.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData(
      {super.key,
      required this.title,
      required this.shortDescription,
      required this.manufacturer,
      required this.price,
      this.originalPrice = 1,
      this.discount = 1,
      required this.child,
      required this.isInStock});

  final String title, shortDescription, manufacturer;
  final bool isInStock;
  final double price, originalPrice, discount;
  final bool child;

  @override
  Widget build(BuildContext context) {
    final discount =
        THelperFunctions.calculateDiscountPercentage(originalPrice, price);
    final rate = LocationController.instance.rate;
    final ccy = LocationController.instance.currencyCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: TSizes.xs,
        ),
        // short description
        Text(
          shortDescription,
          style: Theme.of(context).textTheme.labelLarge,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        //maunfacturer
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Text(
          manufacturer,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        //price
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Row(
          children: [
            if (child)
              Text(
                'Starting at  $ccy ${price * rate}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(fontSizeFactor: 0.7),
              ),
            if (!child)
              Text(
                '$ccy ${price * rate}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(fontSizeFactor: 0.8),
              ),
            const SizedBox(
              width: TSizes.xs,
            ),
            // original price
            if (!child && discount > 0)
              Text(
                '$ccy ${originalPrice * rate}',
                style: Theme.of(context).textTheme.bodySmall!.apply(
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
            const SizedBox(
              width: TSizes.sm,
            ),
            // discount
            if (!child && discount > 0)
              Text(
                '$discount% off',
                style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: TColors.primary,
                    ),
              ),
          ],
        ),
        // stock status
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        // Text(
        //   isInStock ? 'In Stock' : 'Out of Stock',
        //   style: Theme.of(context).textTheme.bodySmall!.apply(
        //         color: isInStock ? TColors.success : TColors.error,
        //       ),
        // ),
      ],
    );
  }
}
