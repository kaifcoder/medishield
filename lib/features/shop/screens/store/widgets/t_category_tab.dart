import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/layouts/grid_layout.dart';
import 'package:medishield/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:medishield/common/widgets/shimmers/product_shimmer.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/shop/controllers/category_tab_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryTabController());
    final productController = ProductController.instance;

    categoryController.changeCategory(category);
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const TSectionHeading(title: 'Related Products'),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Obx(() {
                  if (productController.isLoadingAnother.value) {
                    return const ProductShimmer();
                  }
                  return GridLayout(
                    itemCount: productController.CategoryProducts.length,
                    itemBuilder: (context, index) => ProductCardVertical(
                      product: productController.CategoryProducts[index],
                    ),
                  );
                }),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              ],
            ),
          ),
        ]);
  }
}
