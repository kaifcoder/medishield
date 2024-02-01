import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmer(
                  height: 55,
                  width: 55,
                  radius: 55,
                ),
                SizedBox(
                  width: TSizes.spaceBtwItems / 2,
                ),
                CustomShimmer(
                  height: 8,
                  width: 55,
                ),
              ],
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: TSizes.spaceBtwItems,
            );
          },
          itemCount: itemCount),
    );
  }
}
