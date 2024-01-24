import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class AddressContainer extends StatelessWidget {
  const AddressContainer({
    super.key,
    required this.selected,
  });

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor:
          selected ? TColors.primary.withOpacity(0.1) : Colors.transparent,
      borderColor: selected ? TColors.primary : TColors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(children: [
        Positioned(
          top: 0,
          right: 1,
          child: Icon(
            Iconsax.tick_circle5,
            color: selected ? TColors.primary : TColors.grey,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: TSizes.sm,
            ),
            const Text('+91-1234567890'),
            const Text('ram nagar, delhi, 110092'),
          ],
        )
      ]),
    );
  }
}
