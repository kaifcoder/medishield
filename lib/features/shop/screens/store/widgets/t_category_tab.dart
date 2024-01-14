import 'package:flutter/material.dart';
import 'package:medihealth/common/widgets/custom_shapes/containers/brand_show_case.dart';
import 'package:medihealth/common/widgets/layouts/grid_layout.dart';
import 'package:medihealth/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:medihealth/common/widgets/text/t_section_heading.dart';
import 'package:medihealth/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: Column(
              children: [
                const BrandShowCase(),
                const BrandShowCase(),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TSectionHeading(
                  title: 'Related Products',
                  onButtonPressed: () {},
                  showButton: true,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                GridLayout(
                  itemCount: 4,
                  itemBuilder: (context, index) => const ProductCardVertical(),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              ],
            ),
          ),
        ]);
  }
}
