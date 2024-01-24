import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/utils/constants/sizes.dart';

class BillingAddress extends StatelessWidget {
  const BillingAddress({super.key, required this.showButton});

  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Address',
          buttonTitle: 'change',
          onButtonPressed: () {},
          showButton: showButton,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            Text(
              'Mohd Kaif',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            const Icon(
              Iconsax.call,
              size: 16,
            ),
            const SizedBox(
              width: TSizes.sm,
            ),
            Text(
              '+91-9876543210',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            const Icon(Iconsax.location, size: 16),
            const SizedBox(
              width: TSizes.sm,
            ),
            Flexible(
              child: Text(
                  'address line 1, address line 2, city, state, pincode',
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections / 2,
        ),
      ],
    );
  }
}
