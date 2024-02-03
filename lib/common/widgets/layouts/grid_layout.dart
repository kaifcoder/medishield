import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/shimmers/product_shimmer.dart';
import 'package:medishield/utils/constants/sizes.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
    this.isLoading = false,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const ProductShimmer();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      // scrollDirection: scrollDirection,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
