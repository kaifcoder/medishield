import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/layouts/grid_layout.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/utils/constants/sizes.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
        itemBuilder: (_, __) {
          return const SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmer(height: 180, width: 180),
                SizedBox(height: TSizes.spaceBtwItems),
                CustomShimmer(height: 15, width: 160),
                SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                CustomShimmer(height: 8, width: 15),
              ],
            ),
          );
        },
        itemCount: itemCount);
  }
}
