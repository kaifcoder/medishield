import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/common/widgets/products/cart/t_cart_counter_icon.dart';
import 'package:medishield/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/shop/controllers/all_product_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/features/shop/screens/Search/search.dart';
import 'package:medishield/features/shop/screens/cart/cart.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen(
      {super.key, required this.title, required this.product});

  final String title;
  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    final allProductController = AllProductController.instance;
    final controller = ProductController.instance;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              onPressed: () => Get.to(() => const SearchScreen()),
              icon: const Icon(
                Iconsax.search_normal,
                color: TColors.black,
              ),
            ),
            TCartCounterIcon(
              iconColor: TColors.black,
              onPressed: () {
                if (AuthenticationRepository.instance.deviceStorage
                        .read('guest') ==
                    true) {
                  Get.offAll(() => const LoginScreen());
                } else {
                  Get.to(() => const CartScreen());
                }
              },
            ),
            const SizedBox(
              width: TSizes.md,
            ),
          ],
        ),
        body: product.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('No Product Found'),
                  ),
                ],
              )
            : Obx(() {
                return Column(children: [
                  // filter and sort dropdown

                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                      itemCount: controller.CategoryProducts.length +
                          (controller.isLoadingAnother.value ? 1 : 0),
                      controller: allProductController.scrollController,
                      itemBuilder: (context, index) {
                        if (index < controller.CategoryProducts.length) {
                          return ProductCardHorizontal(
                            product: controller.CategoryProducts[index],
                            isLoadMore: controller.isLoadingAnother.value,
                          );
                        } else {
                          return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: const [
                                SizedBox(
                                  height:
                                      80, // Adjust height according to your loader widget
                                  child: CustomShimmer(
                                      height: 80,
                                      width: double
                                          .infinity), // Or any loader widget
                                ),
                                SizedBox(
                                  height: TSizes.defaultSpace,
                                ),
                                SizedBox(
                                  height:
                                      80, // Adjust height according to your loader widget
                                  child: CustomShimmer(
                                      height: 80,
                                      width: double
                                          .infinity), // Or any loader widget
                                ),
                                SizedBox(
                                  height: TSizes.defaultSpace,
                                ),
                                SizedBox(
                                  height:
                                      80, // Adjust height according to your loader widget
                                  child: CustomShimmer(
                                      height: 80,
                                      width: double
                                          .infinity), // Or any loader widget
                                ),
                              ]);
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: TSizes.spaceBtwItems,
                        );
                      },
                    ),
                  ),
                ]);
              }),
        // sort and filter

        bottomSheet: Obx(() {
          if (controller.isLoadingAnother.value) {
            return const LinearProgressIndicator();
          }
          return const SizedBox();
        }));
  }
}
