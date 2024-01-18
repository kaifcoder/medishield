import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medihealth/utils/constants/sizes.dart';

class ReviewText extends StatelessWidget {
  const ReviewText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Iconsax.star5,
          color: Colors.amber,
          size: 24,
        ),
        const SizedBox(
          width: TSizes.xs,
        ),
        Text(
          '4.5',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          width: TSizes.xs,
        ),
        Text(
          '(3)',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
