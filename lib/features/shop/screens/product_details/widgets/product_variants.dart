import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/features/shop/controllers/location_controller.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class ChildProductDisplay extends StatelessWidget {
  const ChildProductDisplay(
      {super.key,
      required this.selected,
      required this.title,
      required this.price,
      this.ontap});

  final bool selected;
  final String title;
  final double price;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    final rate = LocationController.instance.rate;
    final ccy = LocationController.instance.currencyCode;
    return Column(
      children: [
        TRoundedContainer(
          onPressed: ontap,
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
                  title,
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
                      '$ccy ${price * rate}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(fontSizeFactor: 0.7),
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
