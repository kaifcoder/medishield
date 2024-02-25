import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/utils/constants/sizes.dart';

class ReviewText extends StatelessWidget {
  const ReviewText({
    super.key,
    required this.reviewCount,
    required this.averageRating,
  });

  final String reviewCount;
  final String averageRating;

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
          averageRating,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          width: TSizes.xs,
        ),
        Text(
          '($reviewCount Reviews)',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
