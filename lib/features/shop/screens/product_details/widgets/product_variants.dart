import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class ChildProductDisplay extends StatelessWidget {
  const ChildProductDisplay({super.key, required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor:
              selected ? TColors.primary.withOpacity(0.1) : Colors.transparent,
          borderColor: selected ? TColors.primary : TColors.grey,
          child: Stack(children: [
            Positioned(
              top: 0,
              right: 1,
              child: Icon(selected ? Iconsax.tick_circle5 : null,
                  color: selected ? TColors.primary : Colors.transparent),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //variant title
                Text(
                  'Variant Title some text here and it is long so this will go under icon',
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: TSizes.xs,
                ),
                //variant price
                Row(
                  children: [
                    Text(
                      '₹ 100',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(fontSizeFactor: 0.7),
                    ),
                    const SizedBox(
                      width: TSizes.xs,
                    ),
                    // original price
                    Text(
                      '₹ 200',
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                    const SizedBox(
                      width: TSizes.sm,
                    ),
                    // discount
                    Text(
                      '50% off',
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                            color: TColors.primary,
                          ),
                    ),
                  ],
                ),
                // tier price
                const SizedBox(
                  height: TSizes.xs,
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
