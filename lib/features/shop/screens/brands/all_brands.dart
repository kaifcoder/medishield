import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/layouts/grid_layout.dart';
import 'package:medishield/features/shop/controllers/all_product_controller.dart';
import 'package:medishield/features/shop/controllers/brand_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/screens/Search/search.dart';
import 'package:medishield/features/shop/screens/store/widgets/brand_card.dart';
import 'package:medishield/features/shop/screens/view_all_products/all_product.dart';
import 'package:medishield/utils/constants/sizes.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allProductController = Get.put(AllProductController());
    final controller = BrandController.instance;
    final productController = ProductController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Brands'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.search_normal),
            onPressed: () => Get.to(() => const SearchScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace / 2,
            vertical: TSizes.defaultSpace / 2),
        child: Obx(
          () => GridLayout(
              mainAxisExtent: 80,
              itemCount: controller.brandList.length,
              itemBuilder: (context, index) {
                return BrandCard(
                    image: controller.brandList[index].logo,
                    title: controller.brandList[index].name,
                    isNetworkImage: true,
                    onPressed: () async {
                      allProductController
                          .setTitle(controller.brandList[index].name);
                      allProductController.reset();
                      await productController.fetchProductsbycategory(
                          controller.brandList[index].name, 1);
                      Get.to(
                        () => AllProductScreen(
                          title: controller.brandList[index].name,
                          product: productController.CategoryProducts,
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
